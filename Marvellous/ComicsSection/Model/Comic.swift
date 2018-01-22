//
//  Comic.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 22/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import Foundation

struct Comic: Decodable {
    let id: Int?
    let digitalId: Int?
    let title: String?
    let issueNumber: Double?
    let variantDescription: String?
    let description: String?
    let modified: String?
    let isbn: String?
    let upc: String?
    let diamondCode: String?
    let ean: String?
    let issn: String?
    let format: String?
    let pageCount: Int?
    //let textObjects: [TextObject]?
    let resourceURI: String?
    let urls: [MarvelUrl]?
    let series: Summary?
    let variants: [Summary]?
    let collection: [Summary]?
    let collectedIssues: [Summary]?
    let dates: [MarvelDate]?
    let prices: [Price]?
    let thumbnail: Thumbnail?
    let images: [Thumbnail]?
    let creators: SummaryContainer?
    let characters: SummaryContainer?
    let stories: SummaryContainer?
    let events: SummaryContainer?
}
