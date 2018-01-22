//
//  SeriesDetailViewController.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 21/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import UIKit
import Kingfisher

class SeriesDetailViewController: UIViewController {
    
    var series: Series?
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = series?.title
        
        imgView.kf.setImage(with: series?.thumbnail?.url)
        titleLabel.text = series?.title
        
        if let description = series?.description, !description.isEmpty {
            descriptionLabel.text = description
        } else {
            descriptionLabel.text = "Uhm... no description available"
        }
    }
}
