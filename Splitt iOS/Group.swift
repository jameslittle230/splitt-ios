//
//  Group.swift
//  Splitt iOS
//
//  Created by James Little on 11/12/19.
//  Copyright © 2019 Splitt. All rights reserved.
//

import Foundation

struct SplittGroup: Decodable {
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(Networker.shared.dateFormatter)
        return decoder
    }
    
    let id: UUID
    let createdAt: Date
    let updatedAt: Date
    
    let name: String
    let members: [User]
    let transactions: [Transaction]?
}

struct Transaction: Decodable {
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(Networker.shared.dateFormatter)
        return decoder
    }
    
    let id: UUID
    let createdAt: Date
    let updatedAt: Date
    
    let fullAmount: Int
    let description: String
    let longDescription: String
    let alteredDate: Date?
    let creator: UUID
    let group: UUID
    let deletedAt: Date?
    let splits: [Split]?
}

struct Split: Decodable {
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(Networker.shared.dateFormatter)
        return decoder
    }
    
    let id: UUID
    let createdAt: Date
    let updatedAt: Date
    
    let transaction: UUID
    let amount: Int
    let percentage: Double
    let debtor: UUID
    let reconciliation: UUID?
    let deletedAt: Date?
}
