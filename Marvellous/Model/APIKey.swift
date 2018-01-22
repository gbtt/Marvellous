//
//  APIKey.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 21/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import Foundation

class APIKey {
    static var publicKey = ""
    static var privateKey = ""
    
    static func initialize() {
        if let path = Bundle.main.path(forResource: "APIKeys", ofType: "plist") {
            let keys = NSDictionary(contentsOfFile: path)
            guard let publicKey = keys?["publicKey"] else { return }
            guard let privateKey = keys?["privateKey"] else { return }
            
            APIKey.publicKey = String(describing: publicKey)
            APIKey.privateKey = String(describing: privateKey)
        }
    }
}
