//
//  ComicDetailViewController.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 21/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import UIKit
import Kingfisher

class ComicDetailViewController: UIViewController {
    
    var comic: Comic?
    var charactersName: [String] = []
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = comic?.title
        
        imgView.kf.setImage(with: comic?.thumbnail?.url)
        titleLabel.text = comic?.title
        
        if let description = comic?.description, !description.isEmpty {
            descriptionLabel.text = description
        } else {
            descriptionLabel.text = "Uhm... no description available"
        }
        
        /* This is to show the using of filter and map */
        if let characters = comic?.characters?.items {
            charactersName = characters.filter{$0.name != nil}.map{$0.name!}
        }
        
        collectionView.reloadData()
    }
}

extension ComicDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - UICollectionViewDataSource protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charactersName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCharacterCollectionViewCell.identifier, for: indexPath as IndexPath) as! ComicCharacterCollectionViewCell
        
        cell.titleLabel.text = charactersName[indexPath.item]
        cell.backgroundColor = UIColor.lightGray
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //do nothing
    }
}
