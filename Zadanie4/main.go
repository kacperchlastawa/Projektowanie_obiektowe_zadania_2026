package main

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

type WeatherController struct{}

func (wc *WeatherController) GetWeather(c echo.Context) error {
	city := c.QueryParam("city")
	
	if city == "" {
		city = c.FormValue("city")
	}
	
	if city == "" {
		city = "Warszawa"
	}

	return c.JSON(http.StatusOK, map[string]string{
		"message": "Dane pobrane pomyślnie",
		"city":    city,
		"temp":    "22°C", 
	})
}

func main() {
	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	weatherCtrl := &WeatherController{}

	e.GET("/weather", weatherCtrl.GetWeather)
	e.POST("/weather", weatherCtrl.GetWeather)

	e.Logger.Fatal(e.Start(":8080"))
}