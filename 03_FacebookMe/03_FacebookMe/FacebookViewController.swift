//
//  FacebookViewController.swift
//  03_FacebookMe
//
//  Created by rae on 2021/11/21.
//

import UIKit

class FacebookViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FacebookTableViewCell.self, forCellReuseIdentifier: FacebookTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.topItem?.title = "Facebook"
        navigationController?.navigationBar.barTintColor = UIColor(hex: "#4267B2")
        
        setViews()
    }

    func setViews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    func getRows(section: Int) -> [[String:String]] {
        guard let rows = TableKeys.testData[section][TableKeys.Rows] as? [[String:String]] else {
            fatalError("Unable rows")
        }
        return rows
    }
}

extension FacebookViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableKeys.testData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionName = TableKeys.testData[section][TableKeys.Section] as? String else {
            return nil
        }
        return sectionName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getRows(section: section).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let rows = getRows(section: indexPath.section)
        let title = rows[indexPath.row][TableKeys.Title]
        let userName = "BayMax"
        
        if title == userName {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: nil)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: FacebookTableViewCell.identifier, for: indexPath)
        }
        
        switch title {
        case TableKeys.seeMore, TableKeys.addFavorites:
            if let imageName = rows[indexPath.row][TableKeys.ImageName] {
                cell.imageView?.image = UIImage(named: imageName)
            }
            cell.textLabel?.text = title
            cell.textLabel?.textColor = .blue.withAlphaComponent(0.5)
        case TableKeys.logOut:
            cell.textLabel?.text = title
            cell.textLabel?.textColor = .red
            cell.textLabel?.textAlignment = .center
        default:
            if let imageName = rows[indexPath.row][TableKeys.ImageName] {
                cell.imageView?.image = UIImage(named: imageName)
            }
            cell.textLabel?.text = title
            cell.accessoryType = .disclosureIndicator
            
            if title == userName {
                cell.detailTextLabel?.text = rows[indexPath.row][TableKeys.SubTitle]
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
