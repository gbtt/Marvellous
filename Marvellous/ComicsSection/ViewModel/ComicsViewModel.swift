//
//  ComicsViewModel.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 21/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import Foundation

class ComicsViewModel {
    
    private var comics: [Comic] = []
    private var network = Network()
    
    struct NetworkOffset {
        static let limit = 20
        static var offset = 0
    }
    
    func load(completion: @escaping (Error?) -> ()) {
        network.getComics(limit: NetworkOffset.limit, offset: NetworkOffset.offset) { result, error in
            if error == nil {
                self.updateOffset()
                self.comics += result!
                completion(nil)
            } else {
                completion(error)
            }
        }
    }
    
    func loadMoreIfNeeded(_ indexPath: IndexPath, completion: @escaping(Bool) ->()) {
        if indexPath.row == self.comics.count - 3 {
            load { error in
                completion(error == nil)
            }
        }
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return comics.count
    }
    
    func itemAt(_ indexPath: IndexPath) -> Comic {
        return self.comics[indexPath.row]
    }
    
    
    func comicsIsEmpty() -> Bool {
        return comics.isEmpty
    }
    
    private func updateOffset() {
        NetworkOffset.offset += NetworkOffset.limit
    }
}
