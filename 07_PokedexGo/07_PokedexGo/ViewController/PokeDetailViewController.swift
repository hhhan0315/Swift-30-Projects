//
//  PokeDetailViewController.swift
//  07_PokedexGo
//
//  Created by rae on 2021/12/04.
//

import UIKit

class PokeDetailViewController: UIViewController {
    
    var pokemon: Pokemon? {
        didSet {
            refershUI()
        }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.numberOfLines = 0
        return label
    }()
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        addViews()
        autoLayout()
    }
    
    private func addViews() {
        view.addSubview(nameLabel)
        view.addSubview(descLabel)
        view.addSubview(mainImageView)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mainImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32.0),
            mainImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            mainImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3),
            
            descLabel.topAnchor.constraint(equalTo: mainImageView.topAnchor),
            descLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 32.0),
            descLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func refershUI() {
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name
        descLabel.text = pokemon.desc
        mainImageView.image = UIImage(named: pokemon.imageName)
    }

}

extension PokeDetailViewController: PokeSelectionDelegate {
    func pokeSelected(_ newPokemon: Pokemon) {
        pokemon = newPokemon
    }
}
