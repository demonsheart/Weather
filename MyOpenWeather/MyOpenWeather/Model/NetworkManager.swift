//
//  NetworkManager.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import Foundation

class NetworkManager: NSObject {
    
    struct Key {
        static let openWeather: String = "54316b18318893f2f5d5e112a68ea1ef"
    }
    
    static let lang = "en_US"
    
    struct APIURL {
        
        static func weatherRequest(longitude: Double, latitude: Double) -> String {
            return "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&appid=\(NetworkManager.Key.openWeather)&units=metric&lang=\(NetworkManager.lang)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
        
        static func thirtyWeatherRequest(longitude: Double, latitude: Double) -> String {
            return "https://pro.openweathermap.org/data/2.5/forecast/climate?lat=\(latitude)&lon=\(longitude)&appid=\(NetworkManager.Key.openWeather)&units=metric&lang=\(NetworkManager.lang)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
        
        // 搜索匹配
        static func cityCompletion(for search: String) -> String {
            return "https://api.openweathermap.org/geo/1.0/direct?limit=10&appid=\(NetworkManager.Key.openWeather)&q=\(search)&lang=\(NetworkManager.lang)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
    }
        
}
