//
//  NetworkWeatherModel.swift
//  SunnyWeather
//
//  Created by Артём Устинов on 16.11.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import Foundation

struct NetworkWeatherData: Decodable {
    
    let name: String?
    let main: Main?
    let weather: [Weather]?
}

struct Main: Decodable {
    
    let temp: Double?
    let feelsLike: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather: Decodable {
    
    let id: Int?
}
