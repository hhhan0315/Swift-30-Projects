//
//  AnimationsHomeViewController.swift
//  Project_11_Animations
//
//  Created by rae on 2021/12/13.
//

import UIKit
import SwiftUI

struct VCPreView:PreviewProvider {
    static var previews: some View {
        AnimationsHomeViewController().toPreview()
    }
}

class AnimationsHomeViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let animations = ["2-Color", "Simple 2D Rotation", "Multicolor", "Multi Point Position", "BezierCurve Position", "Color and Frame Change", "View Fade in", "Pop"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  view.backgroundColor = .white
        navigationItem.title = "Animations"
        
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

extension AnimationsHomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Basic Animations"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            fatalError()
        }
        
        cell.textLabel?.text = animations[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension AnimationsHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let nextVC = AnimationsDetailViewController()
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: tableView.frame.height)
        
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.75,
            delay: 0.05 * Double(indexPath.row),
            options: .curveEaseInOut,
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            },
            completion: nil
        )
    }
}
