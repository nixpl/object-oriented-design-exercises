package controllers

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"pl.uj/task4/models"
	"pl.uj/task4/services"
)

type WeatherController struct {
	weatherProvider services.WeatherProvider
}

func NewWeatherController(wp services.WeatherProvider) *WeatherController {
	return &WeatherController{weatherProvider: wp}
}

func (wc *WeatherController) GetWeather(c echo.Context) error {
	cities := c.QueryParams()["city"]
	
	results := []models.Weather{}

	for _, city := range cities {
		weather, err := wc.weatherProvider.GetWeather(city)
		if err == nil {
			results = append(results, *weather)
		}
	}

	return c.JSON(http.StatusOK, results)
}
