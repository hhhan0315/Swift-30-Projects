//
//  CandyDetailViewController.swift
//  06_CandySearch
//
//  Created by rae on 2021/12/02.
//

import UIKit

class CandyDetailViewController: UIViewController {
    var candy: Candy?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
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
        setNavigationController()
        setValues()
        addViews()
        autoLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setNavigationController() {
        guard let candy = candy else { return }
        navigationItem.title = candy.category
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setValues() {
        guard let candy = candy else { return }
        nameLabel.text = candy.name
        mainImageView.image = UIImage(named: candy.name)
    }

    private func addViews() {
        view.addSubview(nameLabel)
        view.addSubview(mainImageView)
    }

    private func autoLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor),

            mainImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            mainImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2),
        ])
    }
}
