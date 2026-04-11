package services

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"

	"pl.uj/task4/models"
)

type WeatherProvider interface {
	GetWeather(city string) (*models.Weather, error)
}

type ExternalWeatherClient struct{}

func (e *ExternalWeatherClient) GetWeather(city string) (*models.Weather, error) {
	geoUrl := fmt.Sprintf("https://geocoding-api.open-meteo.com/v1/search?name=%s&count=1&format=json", city)
	geoResp, err := http.Get(geoUrl)
	if err != nil {
		return nil, err
	}
	defer geoResp.Body.Close()

	var geoResult struct {
		Results []struct {
			Lat float64 `json:"latitude"`
			Lon float64 `json:"longitude"`
		} `json:"results"`
	}
	if err := json.NewDecoder(geoResp.Body).Decode(&geoResult); err != nil {
		return nil, err
	}
	if len(geoResult.Results) == 0 {
		return nil, fmt.Errorf("city not found")
	}

	lat := geoResult.Results[0].Lat
	lon := geoResult.Results[0].Lon

	weatherUrl := fmt.Sprintf("https://api.open-meteo.com/v1/forecast?latitude=%f&longitude=%f&current_weather=true", lat, lon)
	weatherResp, err := http.Get(weatherUrl)
	if err != nil {
		return nil, err
	}
	defer weatherResp.Body.Close()

	var weatherResult struct {
		CurrentWeather struct {
			Temperature float64 `json:"temperature"`
			WeatherCode int     `json:"weathercode"`
		} `json:"current_weather"`
	}
	if err := json.NewDecoder(weatherResp.Body).Decode(&weatherResult); err != nil {
		return nil, err
	}

	return &models.Weather{
		City:        city,
		Temperature: weatherResult.CurrentWeather.Temperature,
		Condition:   "Code: " + strconv.Itoa(weatherResult.CurrentWeather.WeatherCode),
	}, nil
}

type WeatherProxy struct {
	realClient WeatherProvider
}

func NewWeatherProxy(realClient WeatherProvider) *WeatherProxy {
	return &WeatherProxy{realClient: realClient}
}

func (p *WeatherProxy) GetWeather(city string) (*models.Weather, error) {
	log.Printf("[PROXY] Intercepted request for city: %s", city)
	return p.realClient.GetWeather(city)
}
