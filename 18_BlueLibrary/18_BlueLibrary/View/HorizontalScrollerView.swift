//
//  HorizontalScrollerView.swift
//  18_BlueLibrary
//
//  Created by rae on 2021/12/27.
//

import UIKit

class HorizontalScrollerView: UIView {
    weak var dataSource: HorizontalScrollerViewDataSource?
    weak var delegate: HorizontalScrollerViewDelegate?
    
    private enum ViewConstants {
        static let Padding: CGFloat = 10
        static let Dimensions: CGFloat = 100
        static let Offset: CGFloat = 100
    }
    
    private let scroller = UIScrollView()
    
    private var contentViews = [UIView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeScrollView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeScrollView()
    }
    
    func initializeScrollView() {
        addSubview(scroller)
        
        scroller.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scroller.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scroller.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scroller.topAnchor.constraint(equalTo: self.topAnchor),
            scroller.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollerTapped(gesture:)))
        scroller.addGestureRecognizer(tapRecognizer)
        
        scroller.delegate = self
    }
    
    // 특정 index에 대한 view를 검색하고 중앙에 배치
    func scrollToView(at index: Int, animated: Bool = true) {
        let centralView = contentViews[index]
        let targetCenter = centralView.center
        let targetOffsetX = targetCenter.x - (scroller.bounds.width / 2)
        scroller.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: animated)
    }
    
    // 해당 frame에 위치가 있다면 delegate에게 알리고 스크롤
    @objc func scrollerTapped(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: scroller)
        guard let index = contentViews.firstIndex(where: { $0.frame.contains(location) }) else { return }
        delegate?.horizontalScrollerView(self, didSelectViewAt: index)
        scrollToView(at: index)
    }
    
    func view(at index: Int) -> UIView {
        return contentViews[index]
    }
    
    func reload() {
        // dataSource 있는지 확인
        guard let dataSource = dataSource else { return }
        
        // 기존의 view 삭제
        contentViews.forEach{ $0.removeFromSuperview() }
        
        var xValue = ViewConstants.Offset
        
        // dataSource에 numberOfViews를 요청한 후 사용하여 새로운 contentViews를 만들기
        contentViews = (0..<dataSource.numberOfViews(in: self)).map({ index in
            xValue += ViewConstants.Padding
            let view = dataSource.horizontalScrollerView(self, viewAt: index)
            view.frame = CGRect(x: CGFloat(xValue), y: ViewConstants.Padding, width: ViewConstants.Dimensions, height: ViewConstants.Dimensions)
            scroller.addSubview(view)
            xValue += ViewConstants.Dimensions + ViewConstants.Padding
            return view
        })
        
        scroller.contentSize = CGSize(width: CGFloat(xValue + ViewConstants.Offset), height: frame.size.height)
    }
    
    private func centerCurrentView() {
        let centerRect = CGRect(
            origin: CGPoint(x: scroller.bounds.midX - ViewConstants.Padding, y: 0),
            size: CGSize(width: ViewConstants.Padding, height: bounds.height)
        )
        
        guard let selectedIndex = contentViews.firstIndex(where: { $0.frame.intersects(centerRect) }) else { return }
        let centralView = contentViews[selectedIndex]
        let targetCenter = centralView.center
        let targetOffsetX = targetCenter.x - (scroller.bounds.width / 2)
        
        scroller.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
        
        // 중앙에 배치되면 delegate에 변경되었음을 알림
        delegate?.horizontalScrollerView(self, didSelectViewAt: selectedIndex)
    }
}

protocol HorizontalScrollerViewDataSource: AnyObject {
    // horizontal scroller에 view가 몇개인지
    func numberOfViews(in horizontalScrollerView: HorizontalScrollerView) -> Int
    
    // index에 나타나야할 view
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, viewAt index: Int) -> UIView
}

protocol HorizontalScrollerViewDelegate: AnyObject {
    // 해당 index view가 선택되었다는 것 알림
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, didSelectViewAt index: Int)
}

extension HorizontalScrollerView: UIScrollViewDelegate {
    // 사용자가 드래그한 후 변경되었을 수 있기 때문에 현재 current view를 가운데 맞추기
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            centerCurrentView()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        centerCurrentView()
    }
}
