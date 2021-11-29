//
//  ArtistListViewController.swift
//  05_Artistry
//
//  Created by rae on 2021/11/29.
//

import UIKit

class ArtistListViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setNavigationController()
        
    }
    
    func setNavigationController() {
        let textAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.white,
            .font:UIFont.systemFont(ofSize: 24, weight: .semibold)
        ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.topItem?.title = "Artistry"
        navigationController?.navigationBar.barTintColor = .systemGreen
    }


}

