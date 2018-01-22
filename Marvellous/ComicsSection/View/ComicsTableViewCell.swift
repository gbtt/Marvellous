//
//  ComicsTableViewCell.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 21/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import UIKit

protocol ComicsCellDelegate : class {
    func buyButtonDidPressed(_ sender: ComicsTableViewCell)
}

class ComicsTableViewCell: UITableViewCell {
    static let identifier = "ComicsCellId"

    weak var delegate: ComicsCellDelegate?
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBAction func buyButtonDidPressed(_ sender: Any) {
        self.delegate?.buyButtonDidPressed(self)
    }
}
