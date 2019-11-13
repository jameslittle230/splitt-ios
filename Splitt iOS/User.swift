//
//  User.swift
//  Splitt iOS
//
//  Created by James Little on 11/11/19.
//  Copyright © 2019 Splitt. All rights reserved.
//

import Foundation

struct User: Decodable {
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(Networker.shared.dateFormatter)
        return decoder
    }
    
    let id: UUID
    let email: String
    let emailVerifiedAt: Date?
    let createdAt: Date
    let updatedAt: Date
    let apiToken: String?
    let selfCreated: Bool
    let name: String
    let shortName: String?
    let groups: [GroupStub]?
}

struct GroupStub: Decodable {
    let id: UUID
    let createdAt: Date
    let updatedAt: Date
    let name: String
}
