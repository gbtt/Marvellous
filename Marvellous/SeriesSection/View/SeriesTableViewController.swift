//
//  SeriesTableViewController.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 20/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import UIKit
import Kingfisher
import Lottie

class SeriesTableViewController: UITableViewController {
    
    private let viewModel = SerieViewModel()
    
    let searchController = UISearchController(searchResultsController: nil)
    var animationView: LOTAnimationView?
    
    struct SegueIdentifier {
        static let seriesDetail = "seriesDetailSegue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle()
        setSearchController()
        tableView.tableFooterView = UIView()
        
        animationView = animationView(view, name: "colorline")
        animationView?.play()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewModel.seriesIsEmpty() {
            viewModel.load() { error in
                if error == nil {
                    self.tableView.reloadData()
                    self.remove(animationView: self.animationView)
                } else {
                    self.presentAlert(title: "Oh no! Problems...", message: error!.localizedDescription)
                }
            }
        }
    }
    
    private func setTitle() {
        navigationItem.title = "Series"
    }
    
    private func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Filter the list"
        searchController.searchBar.scopeButtonTitles = SerieViewModel.scopeTitles
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func filterContentForSearchText(_ searchText: String, selectedScopeButtonIndex: Int = 0) {
        viewModel.filterContentForSearchText(searchText, selectedScopeButtonIndex: selectedScopeButtonIndex) {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.seriesDetail {
            if let indexPath = tableView.indexPathForSelectedRow {
                let item = viewModel.itemAt(indexPath)
                
                let vc = segue.destination as! SeriesDetailViewController
                vc.series = item
                vc.hidesBottomBarWhenPushed = true
            }
        }
    }
    
}

// MARK: - Table view data source
extension SeriesTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SerieTableViewCell.identifier, for: indexPath) as! SerieTableViewCell
        let series = viewModel.itemAt(indexPath)
        
        cell.titleLabel.text = series.title
        cell.descriptionLabel.text = series.description
        cell.imgView.kf.setImage(with: series.thumbnail?.url)
        
        viewModel.loadMoreIfNeeded(indexPath) { reload in
            if reload {
                self.tableView.reloadData()
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension SeriesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchController.searchBar.text!, selectedScopeButtonIndex: searchBar.selectedScopeButtonIndex)
    }
}

// MARK: - UISearchBarDelegate
extension SeriesTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, selectedScopeButtonIndex: selectedScope)
    }
}

