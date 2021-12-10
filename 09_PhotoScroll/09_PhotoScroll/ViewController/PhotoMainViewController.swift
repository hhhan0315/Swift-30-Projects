//
//  PhotoMainViewController.swift
//  09_PhotoScroll
//
//  Created by rae on 2021/12/07.
//

import UIKit

class PhotoMainViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(PhotoMainCollectionViewCell.self, forCellWithReuseIdentifier: PhotoMainCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let photoImageNames = ["photo1", "photo2", "photo3", "photo4", "photo5", "photo6"]

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Photo Scroll"
        addViews()
        autoLayout()
    }
    
    private func addViews() {
        view.addSubview(collectionView)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension PhotoMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoImageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoMainCollectionViewCell.identifier, for: indexPath) as? PhotoMainCollectionViewCell else {
            return UICollectionViewCell()
        }
        let photoImageName = photoImageNames[indexPath.row]
        
        cell.mainImageView.image = UIImage(named: photoImageName)
        
        return cell
    }
}

extension PhotoMainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let photoImageName = photoImageNames[indexPath.row]
        
        let pageVC = ManagePageViewController()
        pageVC.photoImageNames = photoImageNames
        pageVC.currentIndex = indexPath.row
        
        navigationController?.pushViewController(pageVC, animated: true)
        
//        let nextVC = PhotoDetailViewController()
//        nextVC.photoImageName = photoImageName
//        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension PhotoMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / 5
        return CGSize(width: size, height: size)
    }
}
