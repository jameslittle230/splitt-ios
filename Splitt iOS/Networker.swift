//
//  Networker.swift
//  Splitt iOS
//
//  Created by James Little on 11/10/19.
//  Copyright © 2019 Splitt. All rights reserved.
//

import Foundation

class Networker {
    static var shared = Networker()
    
    var dateFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        APIClient.shared.post(path: "/login", params: [
            "email": email,
            "password": password
        ]) { data, response, error in
            if let data = data {
                do {
                    let loginResponse = try User.decoder.decode(User.self, from: data)
                    completion(.success(loginResponse))
                } catch let error as NSError {
                    print(String(data: data, encoding: .utf8)!)
                    completion(.failure(error))
                }
            } else if let error = error {
                print(response.debugDescription)
                completion(.failure(error))
            }
        }
    }
    
    func getMe(completion: @escaping (Result<User, Error>) -> Void) {
        APIClient.shared.authorizedGet(path: "/me") { data, response, error in
            if let data = data {
                do {
                    let meResponse = try User.decoder.decode(User.self, from: data)
                    completion(.success(meResponse))
                } catch let error as NSError {
                    print(String(data: data, encoding: .utf8)!)
                    completion(.failure(error))
                }
            } else if let error = error {
                print(response.debugDescription)
                completion(.failure(error))
            }
        }
    }
    
    func getGroup(id: UUID, completion: @escaping (Result<SplittGroup, Error>) -> Void) {
        APIClient.shared.authorizedGet(path: "/groups/\(id.uuidString.lowercased())") { data, response, error in
            if let data = data {
                do {
                    let groupResponse = try SplittGroup.decoder.decode(SplittGroup.self, from: data)
                    completion(.success(groupResponse))
                } catch let error as NSError {
                    print(String(data: data, encoding: .utf8)!)
                    completion(.failure(error))
                }
            } else if let error = error {
                print(response.debugDescription)
                completion(.failure(error))
            }
        }
    }
}
