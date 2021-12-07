//
//  AppleNewsViewController.swift
//  08_SimpleRSSReader
//
//  Created by rae on 2021/12/06.
//

import UIKit

class AppleNewsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        let cellNib = UINib(nibName: String(describing: NewsTableViewCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        return tableView
    }()
    
    private var rssItems: [RSSItem]?
    private var cellStates: [CellState]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        autoLayout()
        navigationItem.title = "Apple News"
        
        fetchData()
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

    private func fetchData() {
        let feedParser = FeedParser()
        let url = "https://www.apple.com/newsroom/rss-feed.rss"
        feedParser.parseFeed(url: url) { (rssItems) in
            // 파싱이 잘 끝났을 때 completionHandler 실행
            self.rssItems = rssItems
            self.cellStates = Array(repeating: CellState.collapsed, count: rssItems.count)

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func makeStringToDateToString(_ dateString: String) -> String {
        // 입력 : 2021-12-06T13:58:12.539Z
        let stringToDateFormatter = DateFormatter()
        stringToDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = stringToDateFormatter.date(from: dateString) else {
            return ""
        }
        
        let dateToStringFormatter = DateFormatter()
        dateToStringFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        let resultString = dateToStringFormatter.string(from: date)
        
        return resultString
    }
}

extension AppleNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rssItems = rssItems else { return 0 }
        return rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError("Unable to dequeue NewsTableCell")
        }
        
        guard let rssItems = rssItems else { return UITableViewCell() }
        let rssItem = rssItems[indexPath.row]
        let cellState = cellStates?[indexPath.row]
        
        cell.titleLabel.text = rssItem.title
        cell.dateLabel.text = makeStringToDateToString(rssItem.updated)
        cell.contentsLabel.text = rssItem.content
        cell.contentsLabel.numberOfLines = cellState == .expanded ? 0 : 2
        
        return cell
    }
}

extension AppleNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell else { return }

        tableView.performBatchUpdates({
            cell.contentsLabel.numberOfLines = cell.contentsLabel.numberOfLines == 2 ? 0 : 2
            cellStates?[indexPath.row] = cell.contentsLabel.numberOfLines == 2 ? .collapsed : .expanded
        }, completion: nil)
    }
}
