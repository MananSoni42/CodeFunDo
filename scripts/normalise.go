// To normalise the data of all natural disasters into a standard format
// raw-natural-disasters.json -> natural-disasters.json

package main

import (
	"encoding/json"
	"io/ioutil"
	"math"
	"strconv"
)

func isValidAttr(attr string) bool {
	switch attr {
	case "lat":
		return true
	case "long":
		return true
	case "year":
		return true
	case "month":
		return true
	case "magnitude":
		return true
	case "dead":
		return true
	default:
		return false
	}
	return false
}

func main() {
	f, _ := ioutil.ReadFile("../data/natural-disasters.json")
	var data map[string]map[string]map[string]string
	json.Unmarshal(f, &data)
	normalised := make(map[string][]map[string]int)

	for disaster_type, values := range data {
		normalised[disaster_type] = make([]map[string]int, 0)
		for _, disaster := range values {
			temp := make(map[string]int)
			for attrs, details := range disaster {
				if isValidAttr(attrs) {
					temp_float, _ := strconv.ParseFloat(details, 64)
					temp[attrs] = int(math.Round(temp_float))
				}
			}
			normalised[disaster_type] = append(normalised[disaster_type], temp)
		}
	}
	normalised_json, _ := json.MarshalIndent(normalised, "", "    ")
	ioutil.WriteFile("../data/natural-disasters.json", normalised_json, 0644)

}
