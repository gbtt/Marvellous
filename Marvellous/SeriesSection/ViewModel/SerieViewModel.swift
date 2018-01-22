//
//  SerieViewModel.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 20/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import Foundation

class SerieViewModel {
    static var scopeTitles = ["All", "< 2010", "2010", "> 2010"]
    
    private var series: [Series] = []
    private var filteredSeries = [Series]()
    private var searchText: String = ""
    private var scope: String = ""
    
    private var selectedScopeButtonIndex = 0
    private var network = Network()
    
    struct NetworkOffset {
        static let limit = 20
        static var offset = 0
    }
    
    func load(completion: @escaping (Error?) -> ()) {
        network.getSeries(limit: NetworkOffset.limit, offset: NetworkOffset.offset) { result, error in
            if error == nil {
                self.updateOffset()
                self.series += result!
                completion(nil)
            } else {
                completion(error)
            }
        }
    }
    
    func loadMoreIfNeeded(_ indexPath: IndexPath, completion: @escaping(Bool) ->()) {
        if indexPath.row == self.series.count - 3 {
            load { error in
                completion(error == nil)
            }
        }
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = selectedScopeButtonIndex != 0
        return !searchBarIsEmpty() || searchBarScopeIsFiltering
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        if isFiltering() {
            return filteredSeries.count
        }
        return series.count
    }
    
    func itemAt(_ indexPath: IndexPath) -> Series {
        if isFiltering() {
            return filteredSeries[indexPath.row]
        } else {
            return self.series[indexPath.row]
        }
    }
    
    func filterContentForSearchText(_ searchText: String, selectedScopeButtonIndex: Int, completion: @escaping () -> ()) {
        self.selectedScopeButtonIndex = selectedScopeButtonIndex
        self.scope = SerieViewModel.scopeTitles[selectedScopeButtonIndex]
        self.searchText = searchText
        
        filteredSeries = series.filter({(serie: Series) -> Bool in
            var doesCategoryMatch = scope == "All"
            
            if let startYear = serie.startYear {
                if scope == "< 2010" && startYear < 2010{
                    doesCategoryMatch = true
                } else if scope == "2010" && startYear == 2010 {
                    doesCategoryMatch = true
                } else if scope == "> 2010" && startYear > 2010 {
                    doesCategoryMatch = true
                }
            }
            
            if searchBarIsEmpty() {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && serie.title!.lowercased().contains(searchText.lowercased())
            }
        })
        completion()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchText.isEmpty
    }
    
    func seriesIsEmpty() -> Bool {
        return series.isEmpty
    }
    
    private func updateOffset() {
        NetworkOffset.offset += NetworkOffset.limit
    }
}
