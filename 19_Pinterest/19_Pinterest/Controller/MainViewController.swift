//
//  MainViewController.swift
//  19_Pinterest
//
//  Created by rae on 2021/12/29.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = PinterestLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        collectionView.dataSource = self
//        collectionView.delegate = self
        layout.delegate = self
        return collectionView
    }()
    
    private let photos = Photo.getAllPhotos()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        autoLayout()
    }

    private func addViews() {
        view.addSubview(collectionView)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else {
            fatalError()
        }
        
        let photo = photos[indexPath.row]
        
        cell.photo = photo
        
        return cell
    }
}

extension MainViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return photos[indexPath.item].image.size.height
    }
}
