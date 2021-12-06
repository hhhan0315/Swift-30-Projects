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
        return tableView
    }()
    
    let pokemons = Pokemon.testData
    var delegate: PokeSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        autoLayout()
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

extension PokeMasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokeMasterTableViewCell.identifier, for: indexPath) as? PokeMasterTableViewCell else {
            fatalError("Unable to dequeue PokeMasterCell")
        }
        let pokemon = pokemons[indexPath.row]
        
        cell.numLabel.text = "# \(indexPath.row + 1)"
        cell.nameLabel.text = pokemon.name
        cell.mainImageView.image = UIImage(named: pokemon.imageName)
        
        return cell
    }
}

extension PokeMasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedPokemon = pokemons[indexPath.row]
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

protocol PokeSelectionDelegate {
    func pokeSelected(_ newPokemon: Pokemon)
}
