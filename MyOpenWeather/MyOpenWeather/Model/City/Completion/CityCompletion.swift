//
//  CityCompletion.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import Combine
import Foundation

class CityCompletion: NSObject, ObservableObject {
    
    private var completionManager: CityCompletionManager
        
    @Published var predictions: [CityCompletion.CityData] = []
    
    override init() {
        predictions = []
        completionManager = CityCompletionManager()
        super.init()
    }
    
    func search(_ search: String) {
        completionManager.getCompletion(for: search) { (predictions) in
            DispatchQueue.main.async {
                self.predictions = predictions
            }
        }
    }
    
}
