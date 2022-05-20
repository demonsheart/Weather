//
//  String.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import Foundation

extension String {
    func convertDate(from: String = "yyyy-MM-dd HH:mm:ss", to: String = "MMM dd,yyyy") -> String {
        let dateFormatterGet = DateFormatter()
        // yyyy-MM-dd HH:mm:ss
        dateFormatterGet.dateFormat = from
        
        let dateFormatterPrint = DateFormatter()
        // MMM dd,yyyy
        dateFormatterPrint.dateFormat = to
        
        if self == "0001-01-01 00:00:00" {
            return ""
        }
        
        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date)
        } else {
            return ""
        }
    }
}
