package main

import (
	"github.com/labstack/echo/v4"
	"pl.uj/task4/controllers"
)

func main() {
	e := echo.New()

	weatherCtrl := controllers.NewWeatherController()
	e.GET("/weather", weatherCtrl.GetWeather)

	e.Start(":8080")
}
