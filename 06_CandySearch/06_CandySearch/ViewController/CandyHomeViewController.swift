//
//  CandyHomeViewController.swift
//  06_CandySearch
//
//  Created by rae on 2021/12/02.
//

import UIKit

class CandyHomeViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CandyHomeTableViewCell.self, forCellReuseIdentifier: CandyHomeTableViewCell.identifier)
        return tableView
    }()
    
    private let candies = Candy.testData

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setNavigationController()
        addViews()
        autoLayout()
    }

    private func setNavigationController() {
        // navigation bar에 이미지 넣기
        let imageView = UIImageView(frame: CGRect.zero)
        let image = UIImage(named: "Inline-Logo")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        navigationController?.navigationBar.barTintColor = .systemGreen
    }

    private func addViews() {
        view.addSubview(tableView)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension CandyHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CandyHomeTableViewCell.identifier, for: indexPath) as? CandyHomeTableViewCell else {
            fatalError("Unable dequeue CandyHomeCell")
        }
        
        cell.textLabel?.text = candies[indexPath.row].name
        cell.detailTextLabel?.text = candies[indexPath.row].category
        
        return cell
    }
}

extension CandyHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let candy = candies[indexPath.row]
        
        let nextVC = CandyDetailViewController()
        nextVC.candy = candy
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
