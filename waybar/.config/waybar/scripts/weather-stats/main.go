package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"strings"
	"time"
)

const WTTR_API_URL = "https://wttr.in"

var weatherIcons = map[string]string{
	"Clear":             "󰖙",
	"Sunny":             "󰖙",
	"PartlyCloudy":      "󰖕",
	"Cloudy":            "󰖐",
	"Overcast":          "󰖐",
	"Mist":              "󰖑",
	"Fog":               "󰖑",
	"LightRain":         "󰖗",
	"HeavyRain":         "󰖖",
	"Rain":              "󰖗",
	"LightSnow":         "󰖘",
	"HeavySnow":         "󰖘",
	"Snow":              "󰖘",
	"Thunderstorm":      "󰖓",
	"ThunderyShowers":   "󰖓",
	"ThunderySnow":      "󰖓",
	"Drizzle":           "󰖗",
	"LightShowers":      "󰖗",
	"HeavyShowers":      "󰖖",
	"LightSleet":        "󰖘",
	"HeavySleet":        "󰖘",
	"Sleet":             "󰖘",
	"Clear Night":       "󰖔",
	"PartlyCloudyNight": "󰼱",
}

var weatherCodeIcons = map[string]string{
	"113": "󰖙", // Sunny
	"116": "󰖕", // Partly cloudy
	"119": "󰖐", // Cloudy
	"122": "󰖐", // Overcast
	"143": "󰖑", // Mist
	"176": "󰖗", // Patchy rain possible
	"179": "󰖘", // Patchy snow possible
	"182": "󰖘", // Patchy sleet possible
	"185": "󰖘", // Patchy freezing drizzle possible
	"200": "󰖓", // Thundery outbreaks possible
	"227": "󰖘", // Blowing snow
	"230": "󰖘", // Blizzard
	"248": "󰖑", // Fog
	"260": "󰖑", // Freezing fog
	"263": "󰖗", // Patchy light drizzle
	"266": "󰖗", // Light drizzle
	"281": "󰖘", // Freezing drizzle
	"284": "󰖘", // Heavy freezing drizzle
	"293": "󰖗", // Patchy light rain
	"296": "󰖗", // Light rain
	"299": "󰖗", // Moderate rain at times
	"302": "󰖗", // Moderate rain
	"305": "󰖖", // Heavy rain at times
	"308": "󰖖", // Heavy rain
	"311": "󰖘", // Light freezing rain
	"314": "󰖘", // Moderate or heavy freezing rain
	"317": "󰖘", // Light sleet
	"320": "󰖘", // Moderate or heavy sleet
	"323": "󰖘", // Patchy light snow
	"326": "󰖘", // Light snow
	"329": "󰖘", // Patchy moderate snow
	"332": "󰖘", // Moderate snow
	"335": "󰖘", // Patchy heavy snow
	"338": "󰖘", // Heavy snow
	"350": "󰖘", // Ice pellets
	"353": "󰖗", // Light rain shower
	"356": "󰖖", // Moderate or heavy rain shower
	"359": "󰖖", // Torrential rain shower
	"362": "󰖘", // Light sleet showers
	"365": "󰖘", // Moderate or heavy sleet showers
	"368": "󰖘", // Light snow showers
	"371": "󰖘", // Moderate or heavy snow showers
	"374": "󰖘", // Light showers of ice pellets
	"377": "󰖘", // Moderate or heavy showers of ice pellets
	"386": "󰖓", // Patchy light rain with thunder
	"389": "󰖓", // Moderate or heavy rain with thunder
	"392": "󰖓", // Patchy light snow with thunder
	"395": "󰖓", // Moderate or heavy snow with thunder
}

type WttrResponse struct {
	CurrentCondition []struct {
		TempC       string `json:"temp_C"`
		FeelsLikeC  string `json:"FeelsLikeC"`
		WeatherDesc []struct {
			Value string `json:"value"`
		} `json:"weatherDesc"`
		WeatherCode    string `json:"weatherCode"`
		Humidity       string `json:"humidity"`
		WindspeedKmph  string `json:"windspeedKmph"`
		WinddirDegree  string `json:"winddirDegree"`
		WindDir16Point string `json:"winddir16Point"`
		PrecipMM       string `json:"precipMM"`
	} `json:"current_condition"`
	NearestArea []struct {
		AreaName []struct {
			Value string `json:"value"`
		} `json:"areaName"`
		Country []struct {
			Value string `json:"value"`
		} `json:"country"`
	} `json:"nearest_area"`
}

type WaybarOutput struct {
	Text    string `json:"text"`
	Tooltip string `json:"tooltip"`
	Alt     string `json:"alt"`
	Class   string `json:"class"`
}

func getIcon(condition string, code string) string {
	cleanCondition := strings.ReplaceAll(condition, " ", "")
	cleanCondition = strings.ReplaceAll(cleanCondition, "-", "")

	if icon, exists := weatherIcons[cleanCondition]; exists {
		return icon
	}

	if icon, exists := weatherCodeIcons[code]; exists {
		return icon
	}

	return "󰖐"
}

func getWeather() (WaybarOutput, error) {
	url := fmt.Sprintf("%s/?format=j1", WTTR_API_URL)

	client := &http.Client{
		Timeout: 10 * time.Second,
	}

	resp, err := client.Get(url)
	if err != nil {
		return WaybarOutput{}, err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return WaybarOutput{}, fmt.Errorf("API error: %s", resp.Status)
	}

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return WaybarOutput{}, err
	}

	var weather WttrResponse
	if err := json.Unmarshal(body, &weather); err != nil {
		return WaybarOutput{}, err
	}

	if len(weather.CurrentCondition) == 0 {
		return WaybarOutput{}, fmt.Errorf("no weather data available")
	}

	current := weather.CurrentCondition[0]

	locationName := ""
	if len(weather.NearestArea) > 0 {
		if len(weather.NearestArea[0].AreaName) > 0 {
			locationName = weather.NearestArea[0].AreaName[0].Value
		}

		if len(weather.NearestArea[0].Country) > 0 {
			locationName += ", " + weather.NearestArea[0].Country[0].Value
		}
	}

	weatherCondition := ""
	if len(current.WeatherDesc) > 0 {
		weatherCondition = current.WeatherDesc[0].Value
	}

	weatherIcon := getIcon(weatherCondition, current.WeatherCode)

	temperatureText := fmt.Sprintf("%s°C", current.TempC)

	outputText := fmt.Sprintf("%s %s", weatherIcon, temperatureText)

	windKmph := 0.0
	fmt.Sscanf(current.WindspeedKmph, "%f", &windKmph)
	windMs := windKmph / 3.6

	tooltip := fmt.Sprintf(
		"%s\n%s\nTemperature: %s°C\nFeels like: %s°C\nHumidity: %s%%\nWind: %.1f m/s %s\nPrecipitation: %s mm\nUpdated: %s",
		locationName,
		weatherCondition,
		current.TempC,
		current.FeelsLikeC,
		current.Humidity,
		windMs,
		current.WindDir16Point,
		current.PrecipMM,
		time.Now().Format("15:04:05"),
	)

	weatherClass := "normal"
	lowerCondition := strings.ToLower(weatherCondition)

	if strings.Contains(lowerCondition, "rain") ||
		strings.Contains(lowerCondition, "shower") ||
		strings.Contains(lowerCondition, "drizzle") {
		weatherClass = "rain"
	} else if strings.Contains(lowerCondition, "snow") ||
		strings.Contains(lowerCondition, "sleet") ||
		strings.Contains(lowerCondition, "ice") {
		weatherClass = "snow"
	} else if strings.Contains(lowerCondition, "clear") ||
		strings.Contains(lowerCondition, "sunny") {
		weatherClass = "clear"
	} else if strings.Contains(lowerCondition, "cloud") ||
		strings.Contains(lowerCondition, "overcast") {
		weatherClass = "cloud"
	} else if strings.Contains(lowerCondition, "thunder") ||
		strings.Contains(lowerCondition, "storm") {
		weatherClass = "thunder"
	} else if strings.Contains(lowerCondition, "fog") ||
		strings.Contains(lowerCondition, "mist") {
		weatherClass = "fog"
	}

	return WaybarOutput{
		Text:    outputText,
		Tooltip: tooltip,
		Alt:     weatherCondition,
		Class:   weatherClass,
	}, nil
}

func main() {
	output, err := getWeather()
	if err != nil {
		errorOutput := WaybarOutput{
			Text:    "󰅧 N/A",
			Tooltip: fmt.Sprintf("Error fetching weather: %v", err),
			Alt:     "Error",
			Class:   "error",
		}

		jsonOutput, _ := json.Marshal(errorOutput)
		fmt.Println(string(jsonOutput))
		return
	}

	jsonOutput, err := json.Marshal(output)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error creating JSON: %v\n", err)
		return
	}

	fmt.Println(string(jsonOutput))
}
