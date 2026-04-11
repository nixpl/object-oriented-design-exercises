package controllers

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

type WeatherController struct{}

func NewWeatherController() *WeatherController {
	return &WeatherController{}
}

func (wc *WeatherController) GetWeather(c echo.Context) error {
	return c.JSON(http.StatusOK, map[string]string{
		"city":        "TEST_CITY",
		"temperature": "TEST_TEMPERATURE",
		"condition":   "TEST_CONDITION",
	})
}
