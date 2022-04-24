//
//  APIService.swift
//  Traveler
//
//  Created by Samim Hakimi on 4/23/22.
//

import Foundation

class APIService: NSObject {
    
   
    override init() {
        super.init()
       
    }
    
    func apiToGetWeatherData(cityName: String, completion: @escaping (WeatherMain) ->()) {
        let APIKEY = "fb621d4c063ea1536d18cf7f6ea52605"
        let stringURL =  "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(APIKEY)&units=imperial"
        let url = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        URLSession.shared.dataTask(with: URL(string: url!)!) { ( data, response, error) in

            if let data = data {
                let jsonDecoder = JSONDecoder()
                let weatherData = try! jsonDecoder.decode(WeatherMain.self, from: data)
                completion(weatherData)
            }
        }.resume()
    }
}
