package controllers

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"pl.uj/task4/db"
	"pl.uj/task4/models"
)

type WeatherController struct{}

func NewWeatherController() *WeatherController {
	return &WeatherController{}
}

func (wc *WeatherController) GetWeather(c echo.Context) error {
	var weathers []models.Weather
	db.DB.Find(&weathers)

	return c.JSON(http.StatusOK, weathers)
}
