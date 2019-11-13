//
//  APIClient.swift
//  Splitt iOS
//
//  Created by James Little on 11/10/19.
//  Copyright © 2019 Splitt. All rights reserved.
//

import Foundation

class APIClient {
    enum APIError: Error {
        case authorizedRequestWithNoToken
    }
    
    static var shared = APIClient()
    static var baseURL = URL(string: "http://back.test")
    
    func get(path: String, params: [String: Any]) {
        
    }
    
    func post(path: String, params: [String: Any], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request = URLRequest(url: URL(string: path, relativeTo: APIClient.baseURL)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            let body = try JSONSerialization.data(withJSONObject: params, options: [])
            request.httpBody = body
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }
    
    func authorizedGet(path: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let token = KeychainWrapper.standard.string(forKey: DataStore.apiTokenKey) else {
            completionHandler(nil, nil, APIError.authorizedRequestWithNoToken)
            return
        }
        
        let urlString = "\(path)?api_token=\(token)"
        var request = URLRequest(url: URL(string: urlString, relativeTo: APIClient.baseURL)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }
}
