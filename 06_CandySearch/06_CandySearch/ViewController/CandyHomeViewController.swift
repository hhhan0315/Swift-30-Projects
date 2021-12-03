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
        tableView.tableFooterView = searchFooterView
        return tableView
    }()
    
    private let candies = Candy.testData
    
    private var filteredCandies = [Candy]()
    
    private lazy var searchFooterView: SearchFooterView = {
        let searchFooterView = SearchFooterView()
        searchFooterView.translatesAutoresizingMaskIntoConstraints = false
        searchFooterView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 44.0)
        return searchFooterView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
        searchController.searchBar.delegate = self
        return searchController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setNavigationController()
        addViews()
        autoLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setNavigationController() {
        // navigation bar에 이미지 넣기
        let imageView = UIImageView(frame: CGRect.zero)
        let image = UIImage(named: "Inline-Logo")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        navigationController?.navigationBar.barTintColor = .systemGreen
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
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
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filteredContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCandies = candies.filter { (candy: Candy) -> Bool in
            let doesCategoryMatch = (scope == "All") || (candy.category == scope)
            
            if searchBarIsEmpty() {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && candy.name.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    private func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
}

extension CandyHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            searchFooterView.setIsFilteringToShow(filteredItemCount: filteredCandies.count, of: candies.count)
            return filteredCandies.count
        }
        searchFooterView.setNotFiltering()
        return candies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CandyHomeTableViewCell.identifier, for: indexPath) as? CandyHomeTableViewCell else {
            fatalError("Unable dequeue CandyHomeCell")
        }
        let candy: Candy
        
        if isFiltering() {
            candy = filteredCandies[indexPath.row]
        } else {
            candy = candies[indexPath.row]
        }
        
        cell.textLabel?.text = candy.name
        cell.detailTextLabel?.text = candy.category
        
        return cell
    }
}

extension CandyHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let candy: Candy
        
        if isFiltering() {
            candy = filteredCandies[indexPath.row]
        } else {
            candy = candies[indexPath.row]
        }
        
        let nextVC = CandyDetailViewController()
        nextVC.candy = candy
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension CandyHomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filteredContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension CandyHomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filteredContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
