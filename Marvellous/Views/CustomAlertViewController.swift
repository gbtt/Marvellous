//
//  CustomAlertViewController.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 21/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var titleStr: String?
    var imageUrl: URL?
    
    static func instantiateFromStoryboard() -> CustomAlertViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Common", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "customAlertId") as! CustomAlertViewController
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.90)
        titleLabel.text = titleStr
        imgView.kf.setImage(with: imageUrl)
    }
    
    @IBAction func closeDidPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
