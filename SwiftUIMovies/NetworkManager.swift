//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by Ahmed Hazzaa on 10/20/20.
//  Copyright © 2020 AhmedHazzaa. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getRequest<T: Codable>(endpoint: String, queryItems: [String:String]?, headers: [String:String]?, completion: @escaping (_ error: Error?,_ data: T?) -> ()) {
        
        if var urlComponents = URLComponents(string: endpoint) {
            if let queryItems = queryItems {
                var items = [URLQueryItem]()
                
                queryItems.forEach { (key, value) in
                    
                    let queryItem = URLQueryItem(name: key, value: value)
                    items.append(queryItem)
                }
                
                urlComponents.queryItems = items
            }
            
            guard let url = urlComponents.url else {return}
            print(url)
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            if let headers = headers {
                for header in headers {
                    request.addValue(header.value, forHTTPHeaderField: header.key)
                }
            }
            
            let dataTask = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                
                if let error = error {
                    DispatchQueue.main.async {
                        completion(error, nil)
                    }
                } else if let data = data, let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(nil, decodedData)
                    } catch {
                        completion(error, nil)
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    func postRequest<T: Decodable>(endpoint: String, parameters: [String:Any]?, headers: [String:String]?, completion: @escaping (_ error: Error?, _ data: T?) -> ()) {
        
        if let url = URL(string: endpoint) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            if let params = parameters {
                let jsonParams = try! JSONSerialization.data(withJSONObject: params, options: [])
                request.httpBody = jsonParams
            }
            
            
            if let headers = headers {
                for header in headers {
                    request.setValue(header.value, forHTTPHeaderField: header.key)
                }
            }
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let error = error {
                    DispatchQueue.main.async {
                        completion(error, nil)
                    }
                } else if let data = data, let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        DispatchQueue.main.async {
                            completion(nil, decodedData)
                        }
                    } catch {
                        completion(error, nil)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func fetchImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Image download failed: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            completion(image)
        }.resume()
    }
    
    
}
