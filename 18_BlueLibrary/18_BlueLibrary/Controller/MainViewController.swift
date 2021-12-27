//
//  MainViewController.swift
//  18_BlueLibrary
//
//  Created by rae on 2021/12/27.
//

import UIKit

class MainViewController: UIViewController {
    
//    private let scrollView: uiscrollv
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MusicTableViewCell.self, forCellReuseIdentifier: MusicTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setNavigationController()
        addViews()
        autoLayout()
    }
    
    private func setNavigationController() {
        self.navigationItem.title = "Pop Music"
        self.navigationController?.isToolbarHidden = false
        let undoButton = UIBarButtonItem(systemItem: .undo)
        let flexSpace = UIBarButtonItem(systemItem: .flexibleSpace)
        let trashButton = UIBarButtonItem(systemItem: .trash)
        self.setToolbarItems([undoButton, flexSpace, trashButton], animated: true)
    }
    
    private func addViews() {
    }
    
    private func autoLayout() {

    }
}
