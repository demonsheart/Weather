//
//  CurrentWeather.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import Foundation

/// HourlyWeather && CurrentWeather
struct CurrentWeather: Codable, Identifiable {
    
    var id = UUID()
    
    /// 当前时间、Unix、UTC
    let dt: Double
    
    /// 日出时间、Unix、UTC
    let sunrise: Double?
    
    /// 日落时间，Unix，UTC
    let sunset: Double?
    
    /// 温度。单位 - 默认值：开尔文，公制：摄氏，英制：华氏。
    let temp: Double
    
    /// 温度。这个温度参数解释了人类对天气的感知
    let feelsLike: Double
    
    /// 海平面上的大气压，hPa
    let pressure: Int
    
    /// 湿度， ％
    let humidity: Int
    
    /// 大气温度（根据压力和湿度而变化）低于该温度水滴开始凝结并形成露水。
    let dewPoint: Double
    
    /// 云量，%
    let clouds: Int
    
    /// 当前紫外线指数
    let uvi: Double
    
    /// 平均能见度，米。能见度最大值为10km
    let visibility: Int
    
    /// 风速。单位 - 默认：米/秒，公制：米/秒，英制：英里/小时
    let windSpeed: Double
    
    /// 风向，度数（气象
    let windDeg: Int
    
    /// （如果可用）阵风。单位 - 默认：米/秒，公制：米/秒，英制：英里/小时。
    let windGust: Double?
    
    /// 降水的概率。参数的值在 0 和 1 之间变化，其中 0 等于 0%，1 等于 100%
    let pop: Double?
    
    /// （如果有）最近一小时的雨量，毫米
    let rain: Rain?
    
    /// （如果有）最近一小时的降雪量，毫米
    let snow: Snow?
    
    let weather: [Weather]
    
    /// KFImage(URL(string: icon))
    var icon: String {
        return weather.first?.iconURL ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case temp = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case dewPoint = "dew_point"
        case clouds = "clouds"
        case uvi = "uvi"
        case visibility = "visibility"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case pop = "pop"
        case rain = "rain"
        case snow = "snow"
        case weather = "weather"
    }
}

struct Rain: Codable {
    let the1H: Double
    
    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

struct Snow: Codable {
    let the1H: Double
    
    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - Weather
/// https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2
struct Weather: Codable {
    
    /// 天气状况 ID
    let id: Int
    
    /// 一组天气参数（雨、雪、极端等）
    let main: String
    
    /// 组内的天气状况
    let weatherDescription: String
    
    /// 天气图标 ID
    let icon: String
    
    var iconURL: String {
        return "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case weatherDescription = "description"
        case icon = "icon"
    }
}
