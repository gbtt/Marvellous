//
//  Thumbnail.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 21/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import Foundation

struct Thumbnail: Decodable {
    let path: String?
    let extensionPath: String?
    
    var url: URL? {
        guard let path = path else { return nil }
        guard let extensionPath = extensionPath else { return nil }
        
        return URL(string: path + "." + extensionPath)
    }
    
    private enum CodingKeys: String, CodingKey {
        case path
        case extensionPath = "extension"
    }
}
