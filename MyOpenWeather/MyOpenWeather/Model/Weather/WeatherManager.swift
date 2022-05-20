//
//  WeatherManager.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import Foundation

class WeatherManager {
    
    static func getWeather(for city: City, _ completion: @escaping (_ weather: WeatherModel?) -> Void) {
        guard let url = URL(string: NetworkManager.APIURL.weatherRequest(longitude: city.longitude, latitude: city.latitude)) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(weatherModel)
            } catch {
                print(error)
                completion(nil)
            }
        }.resume()
    }
    
}
