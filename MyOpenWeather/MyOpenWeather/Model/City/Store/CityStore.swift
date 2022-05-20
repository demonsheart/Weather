//
//  CityStore.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import Combine
import Foundation
import UIKit

private let configurationDirectory = NSHomeDirectory() + "/Documents/Store"

class CityStore: ObservableObject {
        
    @Published var cities: [City] {
        didSet {
            needsWrite = true
        }
    }
    
    private var needsWrite: Bool
    private let fileManager: FileManager
    private let configFilePath: String
    
    private let defautCities = [
        City(name: "Xinyi", lon: 111.1032678, lat: 22.4277951),
        City(name: "Shenzhen", lon: 114.0543297, lat: 22.555454),
    ]
    
    
    init() {
        needsWrite = false
        fileManager = .default
        self.configFilePath = configurationDirectory + "/city.json"
        
        if let data = fileManager.contents(atPath: configFilePath) {
            let decoder = JSONDecoder()
            if let model = try? decoder.decode([City].self, from: data) {
                cities = model
                cities.forEach{ $0.getWeather() }
            } else {
                cities = defautCities
            }
        } else {
            cities = defautCities
        }
        
        
        NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: nil) { [weak self] (_) in
            self?.writeToStarageIfNeed()
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.willTerminateNotification, object: nil, queue: nil) { [weak self] (_) in
            self?.writeToStarageIfNeed()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        self.writeToStarageIfNeed()
    }
    
    private func writeToStarageIfNeed() {
        
        guard needsWrite else { return  }
        
        do {
            if !fileManager.fileExists(atPath: configurationDirectory) {
                try fileManager.createDirectory(atPath: configurationDirectory, withIntermediateDirectories: true, attributes: nil)
            }
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(cities)
            
            fileManager.createFile(atPath: configFilePath, contents: data, attributes: nil)
        } catch let error {
            print(error)
        }
    }
}
