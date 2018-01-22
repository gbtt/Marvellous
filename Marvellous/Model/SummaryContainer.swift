//
//  SummaryContainer.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 21/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import Foundation

struct SummaryContainer: Decodable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [Summary]?
}
