//
//  ProductsViewController.swift
//  01_GoodAsOldPhones
//
//  Created by rae on 2021/11/16.
//

import UIKit

class ProductsViewController: UIViewController {
    
    private var productsTableViewDataSource: ProductsTableViewDataSource?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableViewConstraints()
        
        productsTableViewDataSource = ProductsTableViewDataSource()
        tableView.delegate = self
        tableView.dataSource = productsTableViewDataSource
        
        tableView.register(ProductsTableViewCell.self, forCellReuseIdentifier: ProductsTableViewCell.identifier)
        
        // tableView 빈 셀 보이지 않기
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func configureTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}

// delegate 파일도 분리했지만 navigation push 때문에 다시 합침
extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let product = Products.testData[indexPath.row]
        
        let nextVC = ProductsFullScreenViewController()
        nextVC.configureNames(title: product.title, imageName: product.fullScreenImageName)
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
