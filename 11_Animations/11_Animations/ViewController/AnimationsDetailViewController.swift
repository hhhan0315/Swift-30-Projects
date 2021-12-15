//
//  AnimationsDetailViewController.swift
//  Project_11_Animations
//
//  Created by rae on 2021/12/14.
//

import UIKit

class AnimationsDetailViewController: UIViewController {
    
    var animation: Animation!
    private let duration = 1.5
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Animate", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        button.addTarget(self, action: #selector(touchAnimateButton(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = animation.rawValue
        
        addViews()
        autoLayout()
        changeImageView()
    }
    
    private func addViews() {
        view.addSubview(imageView)
        view.addSubview(button)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
        ])
    }
    
    private func changeImageView() {
        switch animation {
        case .bezierCurvePosition:
            let path = UIBezierPath(
                arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY),
                radius: 15,
                startAngle: 0,
                endAngle: .pi * 2,
                clockwise: true
            )
            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.strokeColor = UIColor.red.cgColor
            layer.fillColor = UIColor.red.cgColor
            imageView.layer.addSublayer(layer)
        case .viewFadeIn:
            imageView = UIImageView(image: UIImage(named: "whatsapp"))
            imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width / 2, height: view.frame.width / 2)
            imageView.center = CGPoint(x: view.frame.midX, y: view.frame.midY)
            imageView.backgroundColor = .none
        default:
            imageView.backgroundColor = .red
            imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width / 2, height: view.frame.width / 2)
            imageView.center = CGPoint(x: view.frame.midX, y: view.frame.midY)
        }
        
        view.addSubview(imageView)
    }
    
    @objc func touchAnimateButton(_ sender: UIButton) {
        switch animation {
        case .twoColor:
            changeImageViewColor(UIColor.green)
            
        case .simple2DRotation:
            rotateImageViewInfinite(CGFloat.pi)
            
        case .multicolor:
            changeMultiColor(UIColor.green, UIColor.blue)
            
        case .multiPointPosition:
            moveUp(to: self.imageView.frame.height)
            
        case .bezierCurvePosition:
            let centerPoint = self.imageView.center
            var controlPoint1 = centerPoint
            controlPoint1.y -= 150.0
            var controlPoint2 = controlPoint1
            controlPoint2.x += 20.0
            controlPoint2.y -= 150.0
            var endPoint = centerPoint
            endPoint.x += 40.0
            bezierCurvePosition(endPoint: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            
        case .colorAndFrameChange:
            let firstFrame = self.imageView.frame.insetBy(dx: -40, dy: -40)
            let secondFrame = firstFrame.insetBy(dx: 20, dy: 20)
            let thirdFrame = secondFrame.insetBy(dx: -10, dy: -10)
            colorFrameChange(firstFrame, secondFrame, thirdFrame, UIColor.blue, UIColor.orange, UIColor.gray)
            
        case .viewFadeIn:
            fadeIn()
            
        case .pop:
            pop()
        
        default: break
        }
    }
    
    private func changeImageViewColor(_ color: UIColor) {
        UIView.animate(withDuration: duration) {
            self.imageView.backgroundColor = color
        }
    }
    
    private func rotateImageViewInfinite(_ angle: CGFloat) {
        UIView.animate(withDuration: duration, delay: 0.0, options: [.repeat]) {
            self.imageView.transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    
    private func changeMultiColor(_ color1: UIColor, _ color2: UIColor) {
        UIView.animate(withDuration: duration) {
            self.imageView.backgroundColor = color1
        } completion: { _ in
            self.changeImageViewColor(color2)
        }
    }
    
    private func moveUp(to: CGFloat) {
        UIView.animate(withDuration: duration) {
            self.imageView.transform = CGAffineTransform(translationX: 0, y: -to)
        } completion: { _ in
            UIView.animate(withDuration: self.duration) {
                self.imageView.transform = CGAffineTransform(translationX: 0, y: 0)
            }
        }
    }
    
    private func bezierCurvePosition(endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) {
        let path = UIBezierPath()
        path.move(to: self.imageView.center)
        path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.duration = self.duration

        self.imageView.layer.add(animation, forKey: "animate along path")
        self.imageView.center = endPoint
    }
    
    private func colorFrameChange(_ firstFrame: CGRect, _ secondFrame: CGRect, _ thirdFrame: CGRect,
                                  _ firstColor: UIColor, _ secondColor: UIColor, _ thirdColor: UIColor) {
        UIView.animate(withDuration: self.duration) {
            self.imageView.frame = firstFrame
            self.imageView.backgroundColor = firstColor
        } completion: { _ in
            UIView.animate(withDuration: self.duration) {
                self.imageView.frame = secondFrame
                self.imageView.backgroundColor = secondColor
            } completion: { _ in
                UIView.animate(withDuration: self.duration) {
                    self.imageView.frame = thirdFrame
                    self.imageView.backgroundColor = thirdColor
                }
            }
        }
    }
    
    private func fadeIn() {
        let secondImageView = UIImageView(image: UIImage(named: "facebook"))
        secondImageView.frame = imageView.frame
        secondImageView.alpha = 0
        
        view.insertSubview(secondImageView, aboveSubview: imageView)
        
        UIView.animate(withDuration: duration) {
            self.imageView.alpha = 0
            secondImageView.alpha = 1
        }
    }
    
    private func pop() {
        UIView.animate(withDuration: duration / 4) {
            self.imageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } completion: { _ in
            UIView.animate(withDuration: self.duration / 4) {
                self.imageView.transform = .identity
            }
        }
    }
}
