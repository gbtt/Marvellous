//
//  CharactersViewModel.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 20/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import Foundation

class CharactersViewModel {
    
    private var network = Network()
    
    private var characters: [Character] = []
    private var charactersForSearchResult: [Character] = []
    private var loadingMore = false
    private var searchBarActive = false
    
    struct NetworkOffset {
        static let limit = 20
        static var offset = 0
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        if searchBarActive {
            return self.charactersForSearchResult.count
        }
        return self.characters.count
    }
    
    func itemAt(_ indexPath: IndexPath) -> Character {
        return searchBarActive ? self.charactersForSearchResult[indexPath.item] : self.characters[indexPath.item]
    }
    
    func didSelectItemAt(_ indexPath: IndexPath) -> Character {
        if searchBarActive {
            return charactersForSearchResult[indexPath.item]
        } else {
            return characters[indexPath.item]
        }
    }
    
    func load(completion: @escaping (Error?) -> ()) {
        if loadingMore {
            return
        }
        
        loadingMore = true
        
        network.getCharacters(limit: NetworkOffset.limit, offset: NetworkOffset.offset) {data, error  in
            if let error = error {
                completion(error)
            } else {
                self.updateOffset()
                self.characters += data!
                self.loadingMore = false
                completion(nil)
            }
        }
    }
    
    func loadBySearching(_ searchText: String, completion: @escaping () -> ()) {
        let text = String(describing: searchText)
        
        network.getCharacters(limit: NetworkOffset.limit, offset: 0, nameStartsWith: text) {data, error  in
            if error != nil {
                self.charactersForSearchResult = data!
                completion()
            }
        }
    }
    
    func loadMoreIfNeeded(_ indexPath: IndexPath, completion: @escaping(Bool) ->()) {
        if indexPath.item == self.characters.count - 3 {
            load { error in
                completion(error == nil)
            }
        }
    }
    
    //TODO not used
    private func filterForSearchText(_ searchText: String){
        charactersForSearchResult = characters.filter{$0.name != nil && $0.name!.starts(with: searchText)}
    }
    
    func textDidChange(_ searchText: String, completion: @escaping () -> ()) {
        if searchText.count > 0 {
            searchBarActive = true
            //filterForSearchText(searchText)
            loadBySearching(searchText) {
                completion()
            }
        } else {
            searchBarActive = false
            completion()
        }
    }

    func searchBarClosing() {
        self.charactersForSearchResult.removeAll()
        self.searchBarActive = false
    }
    
    func charactersIsEmpty() -> Bool {
        return characters.isEmpty
    }
    
    private func updateOffset() {
        NetworkOffset.offset += NetworkOffset.limit
    }
}
