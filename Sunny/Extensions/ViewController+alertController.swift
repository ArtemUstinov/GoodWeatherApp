//
//  ViewController+alertController.swift
//  SunnyWeather
//
//  Created by Артём Устинов on 16.11.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

extension ViewController {
    
    //MARK: - Public methods:
    func presentSearchAlertController(withTitle title: String?,
                                      message: String?,
                                      style: UIAlertController.Style,
                                      completionHandler: @escaping (String) -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        alert.addTextField { tf in
            let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
            tf.placeholder = cities.randomElement()
        }
        
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = alert.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(search)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
