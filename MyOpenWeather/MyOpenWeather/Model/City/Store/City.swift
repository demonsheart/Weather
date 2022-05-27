//
//  City.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import Combine
import Foundation

class City: ObservableObject, Codable, Hashable {
    
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name && lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    var name: String
    var longitude: Double
    var latitude: Double
    
    @Published var weather: WeatherModel?
    
    @Published var thirtyWeather: ThirtyWeatherList?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case longitude = "longitude"
        case latitude = "latitude"
    }
    
    init(name: String, lon: Double, lat: Double) {
        self.name = name
        self.longitude = lon
        self.latitude = lat
        self.weather = nil
        self.getWeather()
    }
    
    init(cityData data: CityCompletion.CityData) {
        self.name = data.name
        
        if let local = data.localNames {
            self.name = local.en ?? " "
        }
        
        self.longitude = data.lon
        self.latitude = data.lat
        self.weather = nil
        self.getWeather()
    }
    
    func getWeather() {
        WeatherManager.getWeather(for: self) { (weather) in
            DispatchQueue.main.async {
                self.weather = weather
            }
        }
    }
    
    func getThirtyWeather() {
        // MARK: 暂时只请求一次
        if thirtyWeather != nil { return }
        
        WeatherManager.getThirtyWeather(for: self) { (weather) in
            DispatchQueue.main.async {
                self.thirtyWeather = weather
            }
        }
    }
    
}
