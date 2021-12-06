//
//  PokeMasterViewController.swift
//  07_PokedexGo
//
//  Created by rae on 2021/12/04.
//

import UIKit

class PokeMasterViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PokeMasterTableViewCell.self, forCellReuseIdentifier: PokeMasterTableViewCell.identifier)
        tableView.rowHeight = 180
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    let pokemons = Pokemon.testData
    private var filteredPokemons = [Pokemon]()
    var delegate: PokeSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavItem()
        addViews()
        autoLayout()
    }
    
    private func setNavItem() {
        navigationItem.title = "포켓몬"
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
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredPokemons = pokemons.filter({ (pokemon: Pokemon) in
            return pokemon.name.contains(searchText)
        })
        
        tableView.reloadData()
    }

    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

extension PokeMasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredPokemons.count
        }
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokeMasterTableViewCell.identifier, for: indexPath) as? PokeMasterTableViewCell else {
            fatalError("Unable to dequeue PokeMasterCell")
        }
        let pokemon: Pokemon
        if isFiltering() {
            pokemon = filteredPokemons[indexPath.row]
        } else {
            pokemon = pokemons[indexPath.row]
        }
        
        cell.numLabel.text = "# \(indexPath.row + 1)"
        cell.nameLabel.text = pokemon.name
        cell.mainImageView.image = UIImage(named: pokemon.imageName)
        
        return cell
    }
}

extension PokeMasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPokemon: Pokemon
        if isFiltering() {
            selectedPokemon = filteredPokemons[indexPath.row]
        } else {
            selectedPokemon = pokemons[indexPath.row]
        }

        delegate?.pokeSelected(selectedPokemon)
        
        // iPhone에서 동작
        if let detailVC = delegate as? PokeDetailViewController,
           let detailNavController = detailVC.navigationController {
            splitViewController?.showDetailViewController(detailNavController, sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension PokeMasterViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

protocol PokeSelectionDelegate {
    func pokeSelected(_ newPokemon: Pokemon)
}
