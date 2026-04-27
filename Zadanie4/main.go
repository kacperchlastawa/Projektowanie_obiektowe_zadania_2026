package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"strings"

	"github.com/glebarez/sqlite"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"gorm.io/gorm"
)

type Weather struct {
	gorm.Model
	City        string `json:"city"`
	Temperature string `json:"temperature"`
}

type WeatherProxy struct{}

func (wp *WeatherProxy) FetchFromAPI(city string) (string, error) {
	coords := map[string]string{
		"warszawa": "latitude=52.2298&longitude=21.0118",
		"krakow":   "latitude=50.0614&longitude=19.9366",
		"wroclaw":  "latitude=51.1079&longitude=17.0385",
		"gdansk":   "latitude=54.3521&longitude=18.6464",
	}

	cityLower := strings.ToLower(city)
	coord, exists := coords[cityLower]
	if !exists {
		return "", fmt.Errorf("nieobsługiwane miasto w zewnętrznym API (spróbuj Warszawa, Krakow)")
	}

	url := fmt.Sprintf("https://api.open-meteo.com/v1/forecast?%s&current_weather=true", coord)

	resp, err := http.Get(url)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return "", err
	}

	var result map[string]interface{}
	if err := json.Unmarshal(body, &result); err != nil {
		return "", err
	}

	currentWeather := result["current_weather"].(map[string]interface{})
	temp := currentWeather["temperature"].(float64)

	return fmt.Sprintf("%.1f°C", temp), nil
}

type WeatherController struct {
	DB    *gorm.DB
	Proxy *WeatherProxy
}

func (wc *WeatherController) GetWeather(c echo.Context) error {
	city := c.QueryParam("city")
	if city == "" {
		city = c.FormValue("city")
	}
	if city == "" {
		city = "Warszawa"
	}

	var weatherData Weather
	result := wc.DB.Where("city = ?", city).First(&weatherData)

	if result.Error != nil {
		tempFromAPI, err := wc.Proxy.FetchFromAPI(city)
		if err != nil {
			return c.JSON(http.StatusNotFound, map[string]string{
				"error": "Brak danych w bazie i błąd zewnętrznego API: " + err.Error(),
			})
		}

		return c.JSON(http.StatusOK, map[string]string{
			"source":      "Zewnętrzne API (Proxy)",
			"city":        city,
			"temperature": tempFromAPI,
		})
	}

	return c.JSON(http.StatusOK, map[string]interface{}{
		"source": "Baza Danych GORM",
		"data":   weatherData,
	})
}

func main() {
	db, err := gorm.Open(sqlite.Open("weather.db"), &gorm.Config{})
	if err != nil {
		panic("Nie udało się połączyć z bazą danych")
	}

	db.AutoMigrate(&Weather{})

	var count int64
	db.Model(&Weather{}).Count(&count)
	if count == 0 {
		initialWeatherList := []Weather{
			{City: "Warszawa", Temperature: "15°C"},
		}
		db.Create(&initialWeatherList)
	}

	e := echo.New()
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	weatherCtrl := &WeatherController{
		DB:    db,
		Proxy: &WeatherProxy{},
	}

	e.GET("/weather", weatherCtrl.GetWeather)
	e.POST("/weather", weatherCtrl.GetWeather)

	e.Logger.Fatal(e.Start(":8080"))
}