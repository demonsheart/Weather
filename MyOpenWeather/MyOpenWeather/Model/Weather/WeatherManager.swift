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
    
    static func getThirtyWeather(for city: City, _ completion: @escaping (_ weather: ThirtyWeatherList?) -> Void) {
        guard let url = URL(string: NetworkManager.APIURL.thirtyWeatherRequest(longitude: city.longitude, latitude: city.latitude)) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let weatherModel = try JSONDecoder().decode(ThirtyWeatherList.self, from: data)
                if weatherModel.code == "200" {
                    completion(weatherModel)
                } else {
                    completion(nil)
                }
            } catch {
                print(error)
                completion(nil)
            }
        }.resume()
    }
    
}
