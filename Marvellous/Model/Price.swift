//
//  Price.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 22/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import Foundation

struct Price: Decodable {
    let type: String?
    let price: Float? //in USD
}
