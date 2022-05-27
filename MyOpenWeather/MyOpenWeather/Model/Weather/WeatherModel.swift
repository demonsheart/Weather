//
//  WeatheModel.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import Foundation

struct WeatherModel: Codable {
    
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: CurrentWeather
    let hours: [CurrentWeather]
    let week: [DailyWeather]
//    let alerts: [WeatherAlerts]?
    
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
        case timezone = "timezone"
        case timezoneOffset = "timezone_offset"
        case current = "current"
        case hours = "hourly"
        case week = "daily"
//        case alerts = "alerts"
    }
}

struct WeatherAlerts: Codable {
    /// 警报源的名称
    let senderName: String
    
    /// 警报事件名称
    let event: String
    
    /// 警报开始的日期和时间，Unix，UTC
    let start: Double
    
    /// 警报结束的日期和时间，Unix，UTC
    let end: Double
    
    /// 警报说明
    let description: String
    
    /// 警报说明
    let tags: String
}

struct ThirtyWeatherList: Codable {
    let code: String
    
    let list: [ThirtyDailyWeather]
}
