//
//  Date.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import Foundation

extension Date {
    
    var formattedHour: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: NetworkManager.lang)
        
        return dateFormatter.string(from: self)
    }
    
    var formattedDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: NetworkManager.lang)
        
        return dateFormatter.string(from: self)
    }
    
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        dateformat.locale = Locale(identifier: NetworkManager.lang)
        return dateformat.string(from: self)
    }
}
