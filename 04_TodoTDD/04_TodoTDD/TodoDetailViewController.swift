//
//  TodoDetailViewController.swift
//  04_TodoTDD
//
//  Created by rae on 2021/11/23.
//

import UIKit

class TodoDetailViewController: UIViewController {
    
    var todo: TodoEntity? = nil
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = todo?.title
        label.textAlignment = .center
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = todo?.address
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = todo?.desc
        label.textAlignment = .center
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = todo?.date
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        addView()
        autoLayout()
    }
    
    func addView() {
        view.addSubview(titleLabel)
        view.addSubview(addressLabel)
        view.addSubview(descLabel)
        view.addSubview(timeLabel)
    }
    
    func autoLayout() {
        let guide = view.safeAreaLayoutGuide
        let margin: CGFloat = 20
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin),
            addressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addressLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            descLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: margin),
            descLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: margin),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }

}
