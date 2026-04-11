package models

import "gorm.io/gorm"

type Weather struct {
	gorm.Model
	City        string  `json:"city"`
	Temperature float64 `json:"temperature"`
	Condition   string  `json:"condition"`
}
