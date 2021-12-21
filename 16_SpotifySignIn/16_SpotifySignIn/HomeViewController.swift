//
//  HomeViewController.swift
//  16_SpotifySignIn
//
//  Created by rae on 2021/12/21.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {
    
    private let videoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "login-secondary-logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOG IN", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        button.backgroundColor = UIColor.gray.withAlphaComponent(0.9)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN UP", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        button.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.9)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [logInButton, signUpButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var videoLooper: AVPlayerLooper!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        autoLayout()
        playVideo()
    }

    private func addViews() {
        view.addSubview(videoView)
        videoView.addSubview(logoImageView)
        videoView.addSubview(stackView)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: view.topAnchor),
            videoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: videoView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: videoView.topAnchor, constant: 150.0),
            
            stackView.centerXAnchor.constraint(equalTo: videoView.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: videoView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: videoView.widthAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 80.0),
        ])
    }
    
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "moments", ofType: "mp4") else { return }
        let url = URL(fileURLWithPath: path)
        
        let playerItem = AVPlayerItem(url: url)
        let queuePlayer = AVQueuePlayer(playerItem: playerItem)
        videoLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)

        let playerLayer = AVPlayerLayer(player: queuePlayer)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.videoView.layer.addSublayer(playerLayer)
        
        queuePlayer.play()
        
        self.videoView.bringSubviewToFront(logoImageView)
        self.videoView.bringSubviewToFront(stackView)
    }
}
