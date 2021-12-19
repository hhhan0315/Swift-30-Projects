//
//  MainViewController.swift
//  Project_12_Tumblr
//
//  Created by rae on 2021/12/15.
//

import UIKit

class MainViewController: UIViewController {
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(touchAddButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchButton, addButton, refreshButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.tintColor = .white
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 19/255, green: 38/255, blue: 102/255, alpha: 1)
        addViews()
        autoLayout()
    }
    
    private func addViews() {
        view.addSubview(stackView)
    }

    private func autoLayout() {
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func touchAddButton(_ sender: UIButton) {
        let menuVC = MenuViewController()
        menuVC.modalPresentationStyle = .overFullScreen
        self.present(menuVC, animated: true, completion: nil)
    }
}
