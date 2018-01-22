//
//  ComicsViewController.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 21/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import UIKit
import Lottie

class ComicsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var animationView: LOTAnimationView!
    private var viewModel = ComicsViewModel()
    
    struct SegueIdentifier {
        static let comicDetail = "comicDetailSegue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "ComicsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ComicsTableViewCell.identifier)
        
        tableView.tableFooterView = UIView()
        
        animationView = animationView(view, name: "colorline")
        animationView?.play()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewModel.comicsIsEmpty() {
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
    
    private func showBuyCustomView(_ comic: Comic) {
        let vc = CustomAlertViewController.instantiateFromStoryboard()
        vc.titleStr = comic.title
        vc.imageUrl = comic.thumbnail?.url
        self.present(vc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.comicDetail {
            if let indexPath = tableView.indexPathForSelectedRow {
                let item = viewModel.itemAt(indexPath)
                
                let vc = segue.destination as! ComicDetailViewController
                vc.comic = item
                vc.hidesBottomBarWhenPushed = true
            }
        }
    }
}

extension ComicsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ComicsTableViewCell.identifier, for: indexPath) as! ComicsTableViewCell
        
        let item = viewModel.itemAt(indexPath)
        
        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.description
        cell.imgView.kf.setImage(with: item.thumbnail?.url)
        cell.delegate = self
        
        viewModel.loadMoreIfNeeded(indexPath) { reload in
            if reload {
                self.tableView.reloadData()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIdentifier.comicDetail, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension ComicsViewController: ComicsCellDelegate {
    
    func buyButtonDidPressed(_ sender: ComicsTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            let item = viewModel.itemAt(indexPath)
            
            showBuyCustomView(item)
        }
    }
}
