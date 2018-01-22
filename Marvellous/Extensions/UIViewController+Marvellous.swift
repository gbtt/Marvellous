//
//  UIViewController+Marvellous.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 21/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import UIKit
import Lottie

extension UIViewController {
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func animationView(_ view: UIView, name: String) -> LOTAnimationView {
        let animationView = LOTAnimationView(name: "colorline")
        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        
        view.addSubview(animationView)
        
        return animationView
    }
    
    func remove(animationView view: LOTAnimationView?) {
        view?.stop()
        view?.removeFromSuperview()
    }
    
}
