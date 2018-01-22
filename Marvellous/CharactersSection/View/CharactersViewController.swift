//
//  CharactersViewController.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 20/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import UIKit
import Kingfisher
import Lottie

class CharactersViewController: UIViewController {
    private static let animationDuration = 0.25
    
    @IBOutlet weak var searchBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionTopLayoutConstraint: NSLayoutConstraint!
    
    private let flowLayout = UICollectionViewFlowLayout()
    private var animationView: LOTAnimationView!
    private var viewModel = CharactersViewModel()
    
    struct SegueIdentifier {
        static let characterDetail = "characterDetailSegue"
    }
    
    struct ItemsForRow {
        static let min = 2
        static let max = 3
    }
    
    private var searchBarShown: Bool = false {
        didSet {
            if oldValue {
                self.hideSearchBar()
            } else {
                self.showSearchBar()
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = animationView(view, name: "colorline")
        animationView?.play()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCollectionViewLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewModel.charactersIsEmpty() {
            viewModel.load { error in
                if error == nil {
                    self.collectionView.reloadData()
                    self.remove(animationView: self.animationView)
                } else {
                    self.presentAlert(title: "Oh no! Problems...", message: error!.localizedDescription)
                }
            }
        }
    }
    
    /*
     The view size is about to change, so we invalidate the collection Layout
     After this method viewDidLayoutSubviews is called.
     */
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
    }

    private func setCollectionViewLayout() {
        flowLayout.itemSize = getItemSize()
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.minimumLineSpacing = 2
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
    }
    
    private func getItemSize() -> CGSize {
        var size = (collectionView.frame.size.width - 2) / CGFloat(ItemsForRow.min)
        if size > collectionView.frame.size.height {
            size = (collectionView.frame.size.width - 4) / CGFloat(ItemsForRow.max)
        }
        return CGSize(width: size, height: size)
    }
    
    @IBAction func searchButtonDidPressed(_ sender: Any) {
        searchBarShown = !searchBarShown
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.characterDetail {
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                let item = viewModel.didSelectItemAt(indexPath)
                
                let vc = segue.destination as! CharacterDetailViewController
                vc.character = item
                vc.hidesBottomBarWhenPushed = true
            }
        }
    }
    
    // MARK: SearchBar hiding/showing
    
    private func hideSearchBar() {
        //Remove focus from first responder to close the keyboard
        self.view.endEditing(true)
        
        collectionTopLayoutConstraint.constant = 0
        
        viewModel.searchBarClosing()
        
        //Avoid flickering when hiding the SearchBar and tableView is scrolling
        collectionView.setContentOffset(collectionView.contentOffset, animated: false)
        
        UIView.animate(withDuration: CharactersViewController.animationDuration, delay: 0.0, options: [], animations: {
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.searchBar.isHidden = true
            if !self.searchBar.text!.isEmpty {
                self.searchBar.text = ""
                self.collectionView.reloadData()
            }
        })
    }
    
    private func showSearchBar() {
        searchBar.isHidden = false
        //searchBar.becomeFirstResponder()
        collectionTopLayoutConstraint.constant = searchBar.frame.height
        UIView.animate(withDuration: CharactersViewController.animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
}


extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - UICollectionViewDataSource protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath as IndexPath) as! CharacterCollectionViewCell
        let character = viewModel.itemAt(indexPath)
        
        cell.nameLabel.text = character.name
        cell.imgView.kf.setImage(with: character.thumbnail?.url)
        cell.backgroundColor = UIColor.lightGray
        
        viewModel.loadMoreIfNeeded(indexPath) { reload in
            if reload {
                self.collectionView.reloadData()
            }
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension CharactersViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.textDidChange(searchText) {
            self.collectionView.reloadData()
        }
    }
}
