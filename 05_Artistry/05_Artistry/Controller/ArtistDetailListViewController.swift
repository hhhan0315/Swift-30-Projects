//
//  ArtistDetailListViewController.swift
//  05_Artistry
//
//  Created by rae on 2021/11/29.
//

import UIKit

class ArtistDetailListViewController: UIViewController {
    
    var artist: Artist?
    
    let selectMore = "Select For More Info >"
    var imageHeightConstraint: NSLayoutConstraint?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        let cellNib = UINib(nibName: String(describing: WorkTableViewCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: WorkTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.separatorColor = .darkGray
        tableView.separatorInset.left = 0
        tableView.separatorInset.right = 0
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setNavigationController()
        addViews()
        autoLayout()
    }
    
    private func setNavigationController() {
        guard let artist = artist else { return }
        navigationItem.title = artist.name
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
    
    func getAspectRatioAccordingToiPhones(cellImageFrame:CGSize,downloadedImage: UIImage)->CGFloat {
        let widthOffset = downloadedImage.size.width - cellImageFrame.width
        let widthOffsetPercentage = (widthOffset*100)/downloadedImage.size.width
        let heightOffset = (widthOffsetPercentage * downloadedImage.size.height)/100
        let effectiveHeight = downloadedImage.size.height - heightOffset
        return(effectiveHeight)
    }

}

extension ArtistDetailListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let artist = artist else { return 0 }
        return artist.works.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkTableViewCell.identifier, for: indexPath) as? WorkTableViewCell else {
            fatalError("Unable to dequeue WorkTableViewCell")
        }
        
        guard let artist = artist else { return cell }
        let work = artist.works[indexPath.row]
        
        cell.selectionStyle = .none
        cell.mainImageView.image = UIImage(named: work.image)
        cell.titleLabel.text = work.title
        cell.infoLabel.text = work.expanded ? work.info : selectMore
        
        return cell
    }
}

extension ArtistDetailListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? WorkTableViewCell else {
            return
        }
        
        guard let artistCopy = artist else { return }
        
        var work = artistCopy.works[indexPath.row]
        work.expanded = !work.expanded
        
        artist?.works[indexPath.row] = work

        tableView.performBatchUpdates({
            cell.infoLabel.text = work.expanded ? work.info : selectMore
        }, completion: nil)
        
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
