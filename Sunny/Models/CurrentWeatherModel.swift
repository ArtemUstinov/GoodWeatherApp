//
//  CurrentWeatherModel.swift
//  SunnyWeather
//
//  Created by Артём Устинов on 16.11.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

struct CurrentWeatherModel {
    
    let cityName: String
    
    let temperature: Double
    var stringTemperature: String {
        return String(format: "%.0f", temperature)
    }
    
    let feelsLikeTemperature: Double
    var stringFeelsLikeTemperature: String {
        return String(format: "%.0f", feelsLikeTemperature)
    }
    
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
    init?(networkWeatherData: NetworkWeatherData) {
        cityName = networkWeatherData.name ?? ""
        temperature = networkWeatherData.main?.temp ?? 0
        feelsLikeTemperature = networkWeatherData.main?.feelsLike ?? 0
        conditionCode = networkWeatherData.weather?.first?.id ?? 0
    }
}

