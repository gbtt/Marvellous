//
//  Series.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 22/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import Foundation

struct Series: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let resourceURI: String?
    let urls: [MarvelUrl]?
    let startYear: Int?
    let endYear: Int?
    let rating: String?
    let modified: String?
    let thumbnail: Thumbnail?
    let comics: SummaryContainer?
    let stories: SummaryContainer?
    let events: SummaryContainer?
    let characters: SummaryContainer?
    let creators: SummaryContainer?
    let next: Summary?
    let previous: Summary?
}
