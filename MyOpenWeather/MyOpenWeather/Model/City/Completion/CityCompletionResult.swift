//
//  CityCompletionResult.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import Foundation

extension CityCompletion {
    
    struct CityData: Codable, Identifiable {
        
        var id = UUID()
        
        let name: String
        let localNames: LocalNames?
        let lat: Double
        let lon: Double
        let country: String
        let state: String?
        
        enum CodingKeys: String, CodingKey {
            case name = "name"
            case localNames = "local_names"
            case lat = "lat"
            case lon = "lon"
            case country = "country"
            case state = "state"
        }
    }

    struct LocalNames: Codable {
        let ko: String?
        let vi: String?
        let de: String?
        let ja: String?
        let fr: String?
        let ki: String?
        let sv: String?
        let ur: String?
        let fa: String?
        let no: String?
        let ar: String?
        let en: String?
        let it: String?
        let zh: String?
        let tl: String?
        let ru: String?
        let id: String?
        
        enum CodingKeys: String, CodingKey {
            case ko = "ko"
            case vi = "vi"
            case de = "de"
            case ja = "ja"
            case fr = "fr"
            case ki = "ki"
            case sv = "sv"
            case ur = "ur"
            case fa = "fa"
            case no = "no"
            case ar = "ar"
            case en = "en"
            case it = "it"
            case zh = "zh"
            case tl = "tl"
            case ru = "ru"
            case id = "id"
        }
    }
    
}
