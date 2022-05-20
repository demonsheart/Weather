//
//  City.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import Combine
import Foundation

class City: ObservableObject, Codable, Equatable {
    
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name && lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
        
    var name: String
    var longitude: Double
    var latitude: Double
    
    @Published var weather: WeatherModel?
    
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
    
}
