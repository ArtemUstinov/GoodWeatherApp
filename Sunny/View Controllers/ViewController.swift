//
//  ViewController.swift
//  SunnyWeather
//
//  Created by Артём Устинов on 16.11.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    //MARK: - IBoutlets:
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    //MARK: - Public properties:
    let networkWeatherManager = NetworkWeatherManager.shared
    var currentWeatherModel: CurrentWeatherModel!
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        
        return locationManager
    }()
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        
        networkWeatherManager.onCompletion = { currentWeather in
            DispatchQueue.main.async {
                self.updateInterface(with: currentWeather)
            }
        }
    }
    
    //MARK: - IBActions:
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name",
                                          message: nil, style: .alert) { [unowned self] city in
                                            self.networkWeatherManager.fetchWeather(forRequestType: .cityName(city: city))
        }
    }
}

extension ViewController {
    
    //MARK: - Private methods:
    
    private func updateInterface(with weather: CurrentWeatherModel) {
        cityLabel.text = weather.cityName
        temperatureLabel.text = weather.stringTemperature
        feelsLikeTemperatureLabel.text = weather.stringFeelsLikeTemperature
        weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
    }
}

//MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        let longitude = location.coordinate.longitude
        let latitude = location.coordinate.latitude
        
        networkWeatherManager.fetchWeather(forRequestType: .coordinate(longitude: longitude,
                                                                       latitude: latitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

