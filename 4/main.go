package main

import (
	"github.com/labstack/echo/v4"
	"pl.uj/task4/controllers"
	"pl.uj/task4/db"
)

func main() {
	db.InitDB()

	e := echo.New()

	weatherCtrl := controllers.NewWeatherController()
	e.GET("/weather", weatherCtrl.GetWeather)

	e.Start(":8080")
}
