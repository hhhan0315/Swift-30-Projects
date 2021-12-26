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
        tableView.delegate = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return tableView
    }()
    
    let networkManager = NetworkManager.shared
    
    var movieRecords: [MovieRecord] = []
    let pendingOperations = PendingOperations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Movies"
        
        view.addSubview(tableView)
        
        fetchMovieLists()
    }
    
    private func fetchMovieLists() {
        networkManager.getPopularMovieLists(page: 1) { result in
            switch result {
            case .success(let data):
                for result in data.results {
                    let movieRecord = MovieRecord(title: result.title, posterPath: result.posterPath ?? "")
                    self.movieRecords.append(movieRecord)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func startOperations(for movieRecord: MovieRecord, at indexPath: IndexPath) {
        switch movieRecord.state {
        case .new:
            startDownload(for: movieRecord, at: indexPath)
        case .downloaded:
            startFilter(for: movieRecord, at: indexPath)
        default:
            break
        }
    }
    
    private func startDownload(for movieRecord: MovieRecord, at indexPath: IndexPath) {
        guard pendingOperations.downloadsInProgress[indexPath] == nil else { return }
        let downloader = ImageDownloader(movieRecord)
        
        downloader.completionBlock = {
            if downloader.isCancelled { return }
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
    
    private func startFilter(for movieRecord: MovieRecord, at indexPath: IndexPath) {
        guard pendingOperations.filterInProgress[indexPath] == nil else { return }
        let filter = ImageFilter(movieRecord)
        
        filter.completionBlock = {
            if filter.isCancelled { return }
            DispatchQueue.main.async {
                self.pendingOperations.filterInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        
        pendingOperations.filterInProgress[indexPath] = filter
        pendingOperations.filterQueue.addOperation(filter)
    }
    
    private func suspendAllOperations () {
        pendingOperations.downloadQueue.isSuspended = true
        pendingOperations.filterQueue.isSuspended = true
    }
    
    private func resumeAllOperations () {
        pendingOperations.downloadQueue.isSuspended = false
        pendingOperations.filterQueue.isSuspended = false
    }
    
    private func loadImagesForOnscreenCells () {
        guard let pathsArray = tableView.indexPathsForVisibleRows else { return }
                
        var allPendingOperations = Set(pendingOperations.downloadsInProgress.keys)
        allPendingOperations = allPendingOperations.union(pendingOperations.filterInProgress.keys)
        
        var toBeCancelled = allPendingOperations
        let visiblePaths = Set(pathsArray)
        toBeCancelled.subtract(visiblePaths)
        
        var toBeStarted = visiblePaths
        toBeStarted.subtract(allPendingOperations)
        
        for indexPath in toBeCancelled {
            if let pendingDownload = pendingOperations.downloadsInProgress[indexPath] {
                pendingDownload.cancel()
            }
            pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
            
            if let pendingFiltration = pendingOperations.filterInProgress[indexPath] {
              pendingFiltration.cancel()
            }
            pendingOperations.filterInProgress.removeValue(forKey: indexPath)
        }
        
        for indexPath in toBeStarted {
            let recordToProcess = self.movieRecords[indexPath.row]
            startOperations(for: recordToProcess, at: indexPath)
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            fatalError()
        }
        
        let indicator = UIActivityIndicatorView(style: .medium)
        cell.accessoryView = indicator
        
        let movieRecord = movieRecords[indexPath.row]
        
        cell.titleLabel.text = movieRecord.title
        cell.posterImageView.image = movieRecord.image
        
        cell.selectionStyle = .none
        
        switch movieRecord.state {
        case .new, .downloaded:
            indicator.startAnimating()
            if !tableView.isDragging && !tableView.isDecelerating {
                startOperations(for: movieRecord, at: indexPath)
            }
        case .filtered:
            indicator.stopAnimating()
        case .failed:
            cell.titleLabel.text = "Fail to load"
        }
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
}

extension MainViewController {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        suspendAllOperations()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            loadImagesForOnscreenCells()
            resumeAllOperations()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImagesForOnscreenCells()
        resumeAllOperations()
    }
}
