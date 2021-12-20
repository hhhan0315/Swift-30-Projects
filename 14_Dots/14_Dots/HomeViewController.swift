//
//  HomeViewController.swift
//  14_Dots
//
//  Created by rae on 2021/12/20.
//

import UIKit

class HomeViewController: UIViewController {

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let dotImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dot")
        return imageView
    }()
    
    private let dotImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dot")
        return imageView
    }()
    
    private let dotImageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dot")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        addViews()
        autoLayout()
        startAnimation()
    }
 
    private func addViews() {
        view.addSubview(logoImageView)
        view.addSubview(dotImageView1)
        view.addSubview(dotImageView2)
        view.addSubview(dotImageView3)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100.0),
            
            dotImageView1.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50.0),
            dotImageView1.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40.0),
            
            dotImageView2.topAnchor.constraint(equalTo: dotImageView1.topAnchor),
            dotImageView2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dotImageView3.topAnchor.constraint(equalTo: dotImageView1.topAnchor),
            dotImageView3.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 40.0),
        ])
    }
    
    private func startAnimation() {
        self.dotImageView1.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.dotImageView2.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.dotImageView3.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.6, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.dotImageView1.transform = .identity
        })
        
        UIView.animate(withDuration: 0.6, delay: 0.2, options: [.repeat, .autoreverse], animations: {
            self.dotImageView2.transform = .identity
        })

        UIView.animate(withDuration: 0.6, delay: 0.4, options: [.repeat, .autoreverse], animations: {
            self.dotImageView3.transform = .identity
        })
    }
}
