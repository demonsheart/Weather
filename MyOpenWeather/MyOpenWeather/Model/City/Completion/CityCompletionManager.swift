//
//  CityCompletionManager.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import Foundation

class CityCompletionManager: NSObject {
    
    var completionTask: URLSessionDataTask?
    
    func getCompletion(for search: String, _ completion: @escaping (_ results: [CityCompletion.CityData]) -> Void) {
        guard let url = URL(string: NetworkManager.APIURL.cityCompletion(for: search)) else {
            completion([])
            return
        }
        
        completionTask?.cancel()
        
        completionTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode([CityCompletion.CityData].self, from: data)
                completion(result)
            } catch {
                print(error)
                completion([])
            }
        }
        
        completionTask?.resume()
    }
    
}
