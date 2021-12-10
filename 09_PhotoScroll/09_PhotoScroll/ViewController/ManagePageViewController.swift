//
//  ManagePageViewController.swift
//  09_PhotoScroll
//
//  Created by rae on 2021/12/10.
//

import UIKit

class ManagePageViewController: UIPageViewController {
    var photoImageNames = ["photo1", "photo2", "photo3", "photo4", "photo5", "photo6"]
    var currentIndex: Int!
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [.interPageSpacing: 8])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        let viewController = viewPhotoDetailController(currentIndex ?? 0)
        let viewControllers = [viewController]
        setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
    }
    
    private func viewPhotoDetailController(_ index: Int) -> PhotoDetailViewController {
        let photoDetailVC = PhotoDetailViewController()
        photoDetailVC.photoImageName = self.photoImageNames[index]
        photoDetailVC.photoIndex = index
        return photoDetailVC
    }

}

extension ManagePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? PhotoDetailViewController,
           let index = viewController.photoIndex,
           index > 0 {
            return viewPhotoDetailController(index - 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? PhotoDetailViewController,
           let index = viewController.photoIndex,
           index + 1 < photoImageNames.count {
            return viewPhotoDetailController(index + 1)
        }
        return nil
    }
}
