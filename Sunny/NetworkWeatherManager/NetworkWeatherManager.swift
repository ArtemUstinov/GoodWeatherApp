//
//  NetworkWeatherManager.swift
//  SunnyWeather
//
//  Created by Артём Устинов on 16.11.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(longitude: CLLocationDegrees, latitude: CLLocationDegrees)
    }
    
    //MARK: - Public properties:
    static let shared = NetworkWeatherManager()
    
    var onCompletion: ((CurrentWeatherModel) -> Void)?
    
    //MARK: - Private properties:
    private let apiKey = "a1096735d4a6341609030ca5c30933c4"
    
    //MARK: - Public methods:
    func fetchWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        
        switch requestType {
        case .cityName(let city):
            urlString =
            "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=\(apiKey)"
            
        case .coordinate(let longitude, let latitude):
            urlString =
            "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(apiKey)"
        }
        performRequest(with: urlString)
    }
    
    //MARK: - Private methods:
    private func performRequest(with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let networkWeatherData = try JSONDecoder().decode(NetworkWeatherData.self, from: data)
                guard let currentWearherModel = CurrentWeatherModel(
                    networkWeatherData: networkWeatherData) else { return }
                
                self.onCompletion?(currentWearherModel)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    private init() {}
}
