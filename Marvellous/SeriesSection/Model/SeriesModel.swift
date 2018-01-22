//
//  SeriesModel.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 20/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import Foundation

struct SeriesModel: Decodable {
    let code: Int?
    let status: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: SeriesDataContainer?
    let etag: String?
}

