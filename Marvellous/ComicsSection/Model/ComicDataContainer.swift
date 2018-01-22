//
//  ComicDataContainer.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 22/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import Foundation

struct ComicDataContainer: Decodable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Comic]?
}
