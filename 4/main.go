package main

import (
	"github.com/labstack/echo/v4"
	"pl.uj/task4/controllers"
	"pl.uj/task4/db"
	"pl.uj/task4/services"
)

func main() {
	db.InitDB()

	e := echo.New()

	realClient := &services.ExternalWeatherClient{}
	proxy := services.NewWeatherProxy(realClient)

	weatherCtrl := controllers.NewWeatherController(proxy)
	e.GET("/weather", weatherCtrl.GetWeather)

	e.Start(":8080")
}
