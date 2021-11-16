//
//  ProductsTableViewDataSource.swift
//  01_GoodAsOldPhones
//
//  Created by rae on 2021/11/16.
//

import UIKit

class ProductsTableViewDataSource: NSObject {
    
}

extension ProductsTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Products.testData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductsTableViewCell.identifier, for: indexPath) as? ProductsTableViewCell else {
            fatalError("Unable to deque ProductsTableViewCell")
        }
        let product = Products.testData[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: product.imageName)
        cell.textLabel?.text = product.title
        
        return cell
    }
}
