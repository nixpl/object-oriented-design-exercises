package controllers

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"pl.uj/task4/services"
)

type WeatherController struct {
	weatherProvider services.WeatherProvider
}

func NewWeatherController(wp services.WeatherProvider) *WeatherController {
	return &WeatherController{weatherProvider: wp}
}

func (wc *WeatherController) GetWeather(c echo.Context) error {
	city := c.QueryParam("city")
	if city == "" {
		city = "Krakow"
	}

	weather, err := wc.weatherProvider.GetWeather(city)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}

	return c.JSON(http.StatusOK, weather)
}
