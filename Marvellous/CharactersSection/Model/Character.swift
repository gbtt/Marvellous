//
//  Character.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 22/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import Foundation

struct Character: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let modified: String?
    let resourceURI: String?
    let urls: [MarvelUrl]?
    let thumbnail: Thumbnail?
    let comics: SummaryContainer?
    let stories: SummaryContainer?
    let events: SummaryContainer?
    let series: SummaryContainer?
}
