package db

import (
	"log"

	"github.com/glebarez/sqlite"
	"gorm.io/gorm"
	"pl.uj/task4/models"
)

var DB *gorm.DB

func InitDB() {
	var err error
	DB, err = gorm.Open(sqlite.Open("weather.db"), &gorm.Config{})
	if err != nil {
		log.Fatal("failed to connect database")
	}

	DB.AutoMigrate(&models.Weather{})
	seedData()
}

func seedData() {
	var count int64
	DB.Model(&models.Weather{}).Count(&count)

	if count == 0 {
		testData := []models.Weather{
			{City: "Tokyo", Temperature: 22.5, Condition: "Clear"},
			{City: "New York", Temperature: 18.0, Condition: "Rainy"},
			{City: "Sydney", Temperature: 28.5, Condition: "Sunny"},
		}
		DB.Create(&testData)
	}
}
