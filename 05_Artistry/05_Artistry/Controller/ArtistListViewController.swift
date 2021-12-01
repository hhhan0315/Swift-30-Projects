//  ArtistListViewController.swift
//  05_Artistry
//
//  Created by rae on 2021/11/29.
//

import UIKit

class ArtistListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        let cellNib = UINib(nibName: String(describing: ArtistTableViewCell.self), bundle: nil)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(cellNib, forCellReuseIdentifier: ArtistTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.separatorColor = .darkGray
        tableView.separatorInset.left = 0
        tableView.separatorInset.right = 0
        tableView.tableFooterView = UIView()
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
        navigationItem.title = "Artistry"
        navigationController?.navigationBar.barTintColor = .systemGreen
        navigationController?.navigationBar.tintColor = .white
    }

    private func addViews() {
        view.addSubview(tableView)
    }
    
    private func autoLayout() {
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
        let artist = artistsJson.artists[indexPath.row]

        cell.mainImageView.image = UIImage(named: artist.image)
        cell.nameLabel.text = artist.name
        cell.bioLabel.text = artist.bio
        
        return cell
    }
}

extension ArtistListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let artistsJson = artistsJson else {
            return
        }
        let artist = artistsJson.artists[indexPath.row]
        
        let nextVC = ArtistDetailListViewController()
        nextVC.artist = artist
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
