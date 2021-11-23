//
//  TodoHomeViewController.swift
//  04_TodoTDD
//
//  Created by rae on 2021/11/23.
//

import UIKit

class TodoHomeViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapRightBarButton))
        
        view.backgroundColor = .white
        setViews()
    }
    
    func setViews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    @objc func tapRightBarButton() {
        let nextVC = TodoAddViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
