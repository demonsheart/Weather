//
//  DailyWeather.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import Foundation

struct DailyWeather: Codable, Identifiable {
    
    var id = UUID()
    
    /// 当前时间、Unix、UTC
    let dt: Double
    
    /// 日出时间、Unix、UTC
    let sunrise: Double
    
    /// 日落时间，Unix，UTC
    let sunset: Double
    
    /// 今天月亮升起的时间，Unix，UTC
    let moonrise: Double
    
    /// 今天月亮落下的时间，Unix，UTC
    let moonset: Double
    
    /// 月相。0分别 1是“新月”、0.25“上弦月”、0.5“满月”和0.75“下弦月”。其间的时期分别称为“打蜡新月”、“打蜡隆突”、“渐弱隆突”和“渐弱新月”。
    let moonPhase: Double
    
    /// 从早到晚的温度
    let temp: Temp
    
    /// 这解释了人类对天气的感知 从早到晚
    let feelsLike: FeelsLike
    
    /// 海平面上的大气压，hPa
    let pressure: Int
    
    /// 湿度， ％
    let humidity: Int
    
    /// 大气温度（根据压力和湿度而变化）低于该温度水滴开始凝结并形成露水。
    let dewPoint: Double
    
    /// 风速。单位 - 默认：米/秒，公制：米/秒，英制：英里/小时
    let windSpeed: Double
    
    /// 风向，度数（气象
    let windDeg: Int
    
    ///（如果可用）阵风。单位 - 默认：米/秒，公制：米/秒，英制：英里/小时。
    let windGust: Double?
    
    /// 云量，%
    let clouds: Int
    
    /// 当前紫外线指数
    let uvi: Double
    
    /// 降水的概率。参数的值在 0 和 1 之间变化，其中 0 等于 0%，1 等于 100%
    let pop: Double?
    
    /// （如果有）最近一小时的雨量，毫米
    let rain: Double?
    
    /// （如果有）最近一小时的降雪量，毫米
    let snow: Double?
    
    let weather: [Weather]
    
    /// KFImage(URL(string: icon))
    var icon: String {
        return weather.first?.iconURL ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case moonrise = "moonrise"
        case moonset = "moonset"
        case moonPhase = "moon_phase"
        case temp = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case clouds = "clouds"
        case uvi = "uvi"
        case windGust = "wind_gust"
        case pop = "pop"
        case rain = "rain"
        case snow = "snow"
        case weather = "weather"
    }
}

// MARK: - Temp
struct Temp: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
    
    enum CodingKeys: String, CodingKey {
        case day = "day"
        case min = "min"
        case max = "max"
        case night = "night"
        case eve = "eve"
        case morn = "morn"
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
    
    enum CodingKeys: String, CodingKey {
        case day = "day"
        case night = "night"
        case eve = "eve"
        case morn = "morn"
    }
}
