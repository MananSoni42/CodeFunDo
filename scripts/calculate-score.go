package main

import (
	"encoding/json"
	"io/ioutil"
	"math"
	"time"
)

var gapA = [1][2]int{{90, 179}}
var gapB = [4][2]int{{89, 179}, {91, 179}, {90, 178}, {90, 180}}
var gapC = [4][2]int{{89, 178}, {91, 178}, {89, 180}, {91, 180}}
var gapD = [4][2]int{{88, 179}, {92, 179}, {90, 177}, {90, 181}}
var gapE = [8][2]int{{88, 179}, {92, 179}, {90, 181}, {90, 177}, {88, 179}, {92, 179}, {90, 181}, {90, 177}}
var gapF = [4][2]int{{88, 179}, {92, 179}, {90, 181}, {90, 177}}

func getTimeConstant(dis_year, dis_mon int) float64 {
	curr_year, curr_mon_name, _ := time.Now().Date()
	curr_mon := int(curr_mon_name)
	var time_gap float64
	time_gap = float64(curr_year-dis_year) + float64(curr_mon-dis_mon)/12.0

	return float64(1000000 * math.Pow(math.E, (-time_gap/3)))
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func main() {
	f, _ := ioutil.ReadFile("../data/natural-disasters.json")
	var disasters map[string][]map[string]int
	json.Unmarshal(f, &disasters)

	var score_max [180][360]float64
	var no_earthquake [180][360]int
	var no_flood [180][360]int
	var no_tsunami [180][360]int
	var no_storm [180][360]int
	var score_earthquake [180][360]float64
	var score_flood [180][360]float64
	var score_tsunami [180][360]float64
	var score_storm [180][360]float64
	var temp_score float64

	for _, value := range disasters["earthquake"] {
		if value["magnitude"] == 0 {
			value["magnitude"] = 1
		}
		temp_score = float64(value["magnitude"]) * getTimeConstant(value["year"], value["month"])

		for _, x := range gapA {
			score_earthquake[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 1.00
			no_earthquake[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapB {
			score_earthquake[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.70
			no_earthquake[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapC {
			score_earthquake[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.60
			no_earthquake[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapD {
			score_earthquake[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.50
			no_earthquake[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapE {
			score_earthquake[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.40
			no_earthquake[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapF {
			score_earthquake[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.30
			no_earthquake[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
	}

	for _, value := range disasters["flood"] {
		if value["magnitude"] == 0 {
			value["magnitude"] = 1
		}
		if value["dead"] == 0 {
			value["dead"] = 1
		}
		temp_score = float64(value["dead"]) * float64(value["magnitude"]) * getTimeConstant(value["year"], value["month"])

		for _, x := range gapA {
			score_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 1.00
			no_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapB {
			score_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.70
			no_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapC {
			score_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.60
			no_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapD {
			score_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.50
			no_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapE {
			score_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.40
			no_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapF {
			score_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.30
			no_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
	}
	for _, value := range disasters["tsunami"] {
		if value["magnitude"] == 0 {
			value["magnitude"] = 1
		}
		if value["dead"] == 0 {
			value["dead"] = 1
		}
		temp_score = float64(value["dead"]) * float64(value["magnitude"]) * getTimeConstant(value["year"], value["month"])

		for _, x := range gapA {
			score_tsunami[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 1.00
			no_tsunami[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapB {
			score_tsunami[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.70
			no_tsunami[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapC {
			score_tsunami[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.60
			no_tsunami[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapD {
			score_tsunami[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.50
			no_tsunami[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapE {
			score_tsunami[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.40
			no_tsunami[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapF {
			score_tsunami[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.30
			no_tsunami[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
	}

	for _, value := range disasters["storm"] {
		temp_score = getTimeConstant(value["year"], value["month"])

		for _, x := range gapA {
			score_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 1.00
			no_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapB {
			score_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.70
			no_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapC {
			score_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.60
			no_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapD {
			score_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.50
			no_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapE {
			score_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.40
			no_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
		for _, x := range gapF {
			score_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += temp_score * 0.30
			no_flood[(((value["lat"]+x[0])%180)+180)%180][(((value["long"]+x[1])%360)+360)%360] += 1
		}
	}
	var max_earthquake, max_flood, max_storm, max_tsunami float64
	for x := 0; x < 180; x++ {
		for y := 0; y < 360; y++ {
			max_earthquake = math.Max(max_earthquake, score_earthquake[x][y])
			max_flood = math.Max(max_flood, score_flood[x][y])
			max_storm = math.Max(max_storm, score_storm[x][y])
			max_tsunami = math.Max(max_tsunami, score_tsunami[x][y])
		}
	}
	for x := 0; x < 180; x++ {
		for y := 0; y < 360; y++ {
			score_earthquake[x][y] = score_earthquake[x][y] * 10.0 / max_earthquake
			score_flood[x][y] = score_flood[x][y] * 10.0 / max_flood
			score_storm[x][y] = score_storm[x][y] * 10.0 / max_storm
			score_tsunami[x][y] = score_tsunami[x][y] * 10.0 / max_tsunami
		}
	}
	for x := 0; x < 180; x++ {
		for y := 0; y < 360; y++ {
			score_max[x][y] = math.Max(score_flood[x][y], score_earthquake[x][y])
			score_max[x][y] = math.Max(score_max[x][y], score_tsunami[x][y])
			score_max[x][y] = math.Max(score_max[x][y], score_storm[x][y])
		}
	}

	final_json := make(map[int]map[int]map[string]int)
	for x := -90; x < 90; x++ {
		final_json[x] = make(map[int]map[string]int)
		for y := -179; y <= 180; y++ {
			final_json[x][y] = make(map[string]int)
			final_json[x][y]["score"] = int(score_max[x+90][y+179] * 10)
			final_json[x][y]["earthquake"] = no_earthquake[x+90][y+179]
			final_json[x][y]["tsunami"] = no_tsunami[x+90][y+179]
			final_json[x][y]["storm"] = no_storm[x+90][y+179]
			final_json[x][y]["flood"] = no_flood[x+90][y+179]
		}
	}
	json_content, _ := json.MarshalIndent(final_json, "", "    ")
	ioutil.WriteFile("../data/scores.json", json_content, 0644)
}
