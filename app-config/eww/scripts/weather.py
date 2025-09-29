
#!/usr/bin/env python3
import requests
import json

# Fetch weather data
url = "https://wttr.in/Raleigh?format=j1"
try:
    response = requests.get(url, timeout=5)
    weather_data = response.json()

    # Extract temperature in Fahrenheit
    temp = weather_data["current_condition"][0]["temp_F"]
    condition = weather_data["current_condition"][0]["weatherDesc"][0]["value"]

    # Assign icon based on weather condition
    icons = {
        "Clear": "", "Sunny": "",
        "Partly cloudy": "",
        "Cloudy": "", "Overcast": "",
        "Mist": "", "Fog": "", "Haze": "",
        "Patchy rain possible": "", "Light rain": "", "Showers": "",
        "Moderate rain": "", "Heavy rain": "", "Torrential rain": "",
        "Patchy snow possible": "", "Light snow": "",
        "Moderate snow": "", "Heavy snow": "",
        "Thunderstorm": "", "Thundery outbreaks possible": "",
        "Drizzle": "",
        "Sleet": ""
    }
    icon = icons.get(condition, "")  # Default to cloudy if unknown

    # Output JSON for Waybar
    print(json.dumps({"temp": f"{temp}°F", "condition": condition, "icon": icon}))

except Exception as e:
    print(json.dumps({"temp": "N/A", "condition": "Unavailable", "icon": ""}))
