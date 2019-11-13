//
//  DataStore.swift
//  Splitt iOS
//
//  Created by James Little on 11/11/19.
//  Copyright © 2019 Splitt. All rights reserved.
//

import Foundation

class DataStore {
    static var shared = DataStore()
    static let apiTokenKey = "xyz.splitt.Splitt-iOS.api-token"
    
    var loginResponse: User? {
        didSet {
            guard let token = DataStore.shared.loginResponse?.apiToken else {
                fatalError()
            }
            
            KeychainWrapper.standard.removeAllKeys()
            KeychainWrapper.standard.set(token, forKey: DataStore.apiTokenKey)
            DataStore.shared.getMe()
        }
    }
   
    var me: User? {
        didSet {
            if let me = me, let groupstub = me.groups?[0] {
                DataStore.shared.getGroup(id: groupstub.id)
            }
        }
    }
    
    var currentGroup: SplittGroup? {
        didSet {
            print(DataStore.shared.currentGroup?.transactions?[0].splits?.count)
        }
    }
//    var history: [Event]
//    var debts: [Debt]
    
    func getLoginResponse() {
        Networker.shared.login(email: "j@gmail.com", password: "asdfasdf") { result in
            switch result {
            case .success(let response):
                self.loginResponse = response
            case .failure(let error):
                fatalError("\(error)")
            }
        }
    }
    
    func getMe() {
        Networker.shared.getMe() { result in
            switch result {
            case .success(let response):
                self.me = response
            case .failure(let error):
                fatalError("\(error)")
            }
        }
    }
    
    func getGroup(id: UUID) {
        Networker.shared.getGroup(id: id) { result in
            switch result {
            case .success(let response):
                self.currentGroup = response
            case .failure(let error):
                fatalError("\(error)")
            }
        }
    }
//    
//    func getDebts() {
//        Networker.shared.getDebts() { result in
//            switch result {
//            case .success(let response):
//                self.debts = response
//            case .failure(let error):
//                fatalError("\(error)")
//            }
//        }
//    }
//    
//    func getHistory() {
//        Networker.shared.getGroup() { result in
//            switch result {
//            case .success(let response):
//                self.history = response
//            case .failure(let error):
//                fatalError("\(error)")
//            }
//        }
//    }
}
