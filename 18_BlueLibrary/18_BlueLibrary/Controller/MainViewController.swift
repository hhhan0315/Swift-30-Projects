//
//  MainViewController.swift
//  18_BlueLibrary
//
//  Created by rae on 2021/12/27.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var horizontalScrollerView: HorizontalScrollerView = {
        let scrollerView = HorizontalScrollerView()
        scrollerView.translatesAutoresizingMaskIntoConstraints = false
        scrollerView.backgroundColor = .lightGray
        scrollerView.delegate = self
        scrollerView.dataSource = self
        return scrollerView
    }()
    
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
        
        horizontalScrollerView.reload()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        horizontalScrollerView.scrollToView(at: currentAlbumIndex, animated: false)
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
        view.addSubview(horizontalScrollerView)
        view.addSubview(tableView)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            horizontalScrollerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            horizontalScrollerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalScrollerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalScrollerView.heightAnchor.constraint(equalToConstant: 120.0),
            
            tableView.topAnchor.constraint(equalTo: horizontalScrollerView.bottomAnchor),
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
    
    override func encodeRestorableState(with coder: NSCoder) {
        coder.encode(currentAlbumIndex, forKey: Constants.indexRestorationKey)
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        currentAlbumIndex = coder.decodeInteger(forKey: Constants.indexRestorationKey)
        showDataForAlbum(at: currentAlbumIndex)
        horizontalScrollerView.reload()
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

extension MainViewController: HorizontalScrollerViewDelegate {
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, didSelectViewAt index: Int) {
        let previousAlbumView = horizontalScrollerView.view(at: currentAlbumIndex) as! AlbumView
        previousAlbumView.highlightAlbum(false)
        
        currentAlbumIndex = index
        
        let albumView = horizontalScrollerView.view(at: currentAlbumIndex) as! AlbumView
        albumView.highlightAlbum(true)
        showDataForAlbum(at: index)
    }
}

extension MainViewController: HorizontalScrollerViewDataSource {
    func numberOfViews(in horizontalScrollerView: HorizontalScrollerView) -> Int {
        return allAlbums.count
    }
    
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, viewAt index: Int) -> UIView {
        let album = allAlbums[index]
        let albumView = AlbumView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), coverUrl: album.coverUrl)
        if currentAlbumIndex == index {
            albumView.highlightAlbum(true)
        } else {
            albumView.highlightAlbum(false)
        }
        return albumView
    }
}

// MARK:- Constants
enum Constants {
    static let indexRestorationKey = "currentAlbumIndex"
}
