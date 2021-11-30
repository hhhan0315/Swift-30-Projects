//
//  ArtistListViewController.swift
//  05_Artistry
//
//  Created by rae on 2021/11/29.
//

import UIKit

class ArtistListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ArtistTableViewCell.self, forCellReuseIdentifier: ArtistTableViewCell.identifier)
        tableView.dataSource = self
        return tableView
    }()
    
    let artistsJson: ArtistsJson? = {
        guard let artistsJson = ArtistsJson.jsonFromBundle() else {
            return nil
        }
        return artistsJson
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setNavigationController()
        addViews()
        autoLayout()
    }
    
    private func setNavigationController() {
        let textAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.white,
            .font:UIFont.systemFont(ofSize: 24, weight: .semibold)
        ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.topItem?.title = "Artistry"
        navigationController?.navigationBar.barTintColor = .systemGreen
    }

    private func addViews() {
        view.addSubview(tableView)
    }
    
    private func autoLayout() {
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
}

extension ArtistListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let artistsJson = artistsJson else {
            return 0
        }
        return artistsJson.artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier, for: indexPath) as? ArtistTableViewCell else {
            fatalError("Unable dequeue ArtistCell")
        }
        
        guard let artistsJson = artistsJson else {
            return cell
        }
        
        cell.textLabel?.text = artistsJson.artists[indexPath.row].bio
        
        return cell
    }
}
