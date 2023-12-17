//
//  ViewController.swift
//  weatherApp
//
//  Created by Гаджидавуд Серкилов on 06.12.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var weatherLabelRef: UILabel!
    @IBOutlet var getWeatherRef: UIButton!
    @IBOutlet var buttonConsole: UIButton!
    @IBOutlet var labelText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherRef.addTarget(self, action: #selector(handleGetWeatherButton), for: .touchUpInside)
        
        buttonConsole.addTarget(self, action: #selector(handleConsoleClick), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func handleConsoleClick() {
        var count: Int = 0
        count += 2
        labelText.text = "\(count)"
    }

    @objc func handleGetWeatherButton() {
        let urlHref = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true"
        let url = URL(string: urlHref)!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) {
            data, response, error in
            if let data = data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
//                print(weather.currentWeather.temperature)
                DispatchQueue.main.async {
                    self.weatherLabelRef.text = "\(weather.currentWeather.temperature)°"
                }
                
            } else {
                print("Fail parsed")
            }
        }
        task.resume()
    }

}

