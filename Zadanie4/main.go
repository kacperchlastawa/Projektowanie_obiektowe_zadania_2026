package main

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/glebarez/sqlite" 
	"gorm.io/gorm"
)

type Weather struct {
	gorm.Model 
	City        string `json:"city"`
	Temperature string `json:"temperature"`
}

type WeatherController struct {
	DB *gorm.DB
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
		return c.JSON(http.StatusNotFound, map[string]string{
			"message": "Brak danych dla miasta: " + city,
		})
	}

	return c.JSON(http.StatusOK, weatherData)
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
			{City: "Krakow", Temperature: "16°C"},
			{City: "Wroclaw", Temperature: "18°C"},
			{City: "Gdansk", Temperature: "12°C"},
		}
		db.Create(&initialWeatherList)
	}

	e := echo.New()
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	weatherCtrl := &WeatherController{
		DB: db,
	}

	e.GET("/weather", weatherCtrl.GetWeather)
	e.POST("/weather", weatherCtrl.GetWeather)

	e.Logger.Fatal(e.Start(":8080"))
}