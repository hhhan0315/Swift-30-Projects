//
//  MainViewController.swift
//  17_Movies
//
//  Created by rae on 2021/12/22.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.dataSource = self
        return tableView
    }()
    
    var results: [Results] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Movies"
        
        view.addSubview(tableView)
        
        fetchMovies()
    }
    
    private func fetchMovies() {
        let networkManager = NetworkManager.shared
        
        networkManager.getMovies(page: 1) { result in
            switch result {
            case .success(let data):
                self.results = data.results
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let result = results[indexPath.row]
        cell.textLabel?.text = result.title
        return cell
    }
}
