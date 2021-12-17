//
//  UIViewController+Preview.swift
//  Project_12_Tumblr
//
//  Created by rae on 2021/12/15.
//

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    
    func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif
