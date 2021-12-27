//
//  MainViewController.swift
//  18_BlueLibrary
//
//  Created by rae on 2021/12/27.
//

import UIKit

class MainViewController: UIViewController {
    
//    private let scrollView: uiscrollv
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MusicTableViewCell.self, forCellReuseIdentifier: MusicTableViewCell.identifier)
        tableView.dataSource = self
        return tableView
    }()
    
    private var currentAlbumIndex = 0
    private var currentAlbumData: [AlbumData]?
    private var allAlbums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        allAlbums = LibraryAPI.shared.getAlbums()
        showDataForAlbum(at: currentAlbumIndex)
        
        setNavigationController()
        addViews()
        autoLayout()
    }
    
    private func setNavigationController() {
        self.navigationItem.title = "Pop Music"
        self.navigationController?.isToolbarHidden = false
        let undoButton = UIBarButtonItem(systemItem: .undo)
        let flexSpace = UIBarButtonItem(systemItem: .flexibleSpace)
        let trashButton = UIBarButtonItem(systemItem: .trash)
        self.setToolbarItems([undoButton, flexSpace, trashButton], animated: true)
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
    
    private func showDataForAlbum(at index: Int) {
        if -1 < index && index < allAlbums.count {
            let album = allAlbums[index]
            currentAlbumData = album.tableRepresentation
        } else {
            currentAlbumData = nil
        }
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let albumData = currentAlbumData else { return 0 }
        return albumData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MusicTableViewCell.identifier, for: indexPath) as? MusicTableViewCell else {
            fatalError()
        }
        
        guard let albumData = currentAlbumData else {
            return cell
        }
        
        let row = indexPath.row
        cell.textLabel?.text = albumData[row].title
        cell.detailTextLabel?.text = albumData[row].value
        
        return cell
    }
}
