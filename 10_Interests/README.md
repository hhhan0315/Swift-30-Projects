# 스크린샷
![10](https://github.com/hhhan0315/Swift-30-Projects/blob/main/10_Interests/10.gif)

# blur 효과 넣기
> 참고 : https://zeddios.tistory.com/1140
```swift
private let visualEffectView: UIVisualEffectView = {
    let blurEffect = UIBlurEffect(style: .light)
    let visualEffectView = UIVisualEffectView(effect: blurEffect)
    visualEffectView.translatesAutoresizingMaskIntoConstraints = false
    return visualEffectView
}()
```
- `UIImageView`를 배경으로 해둔다.
- `UIImageView` 위에 `UIVisualEffectView`를 추가한다.

<img src="https://github.com/hhhan0315/Swift-30-Projects/blob/main/10_Interests/blur.png" width=300>

# CollectionView Carousel
> 파트1 : https://www.youtube.com/watch?v=JG7mWFcU0vk
> 
> 파트2 : https://www.youtube.com/watch?v=_d-xZv0JrRE
- `Carousel` : 회전목마
## ⭐️ Paging
> 참고 : https://eunjin3786.tistory.com/203
- cell 들간에 spacing을 주면 직접 설정해줘야 한다.
- `velocity.x < 0` : 좌측
- `velocity.x > 0` : 우측
```swift
extension InterestHomeViewController:  UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
        let index: Int
        if velocity.x > 0 {
            index = Int(ceil(estimatedIndex))
        } else if velocity.x < 0 {
            index = Int(floor(estimatedIndex))
        } else {
            index = Int(round(estimatedIndex))
        }
        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing, y: 0)
    }
}
```
- 아래 방법처럼 layout의 `itemSize`를 동적으로 설정해줘서 계속 원하는 Paging이 동작하지 않았다.
- 위의 `layout.itemSize.width`이 `50`으로만 잡혔다.
```swift
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = floor(collectionView.frame.width * 0.6)
    let height = floor(collectionView.frame.height * 0.6)
    return CGSize(width: width, height: height)
}
```
- 직접 사이즈를 설정해줬다.
```swift
let layout = UICollectionViewFlowLayout()
layout.scrollDirection = .horizontal
layout.minimumLineSpacing = 20
let width = floor(view.frame.width * 0.6)
let height = floor(view.frame.height * 0.6)
layout.itemSize = CGSize(width: width, height: height)
```

|기능 전|기능 후|
|--|--|
|![paging1](https://github.com/hhhan0315/Swift-30-Projects/blob/main/10_Interests/paging1.gif)|![paging2](https://github.com/hhhan0315/Swift-30-Projects/blob/main/10_Interests/paging2.gif)|

# UIImageView 모서리 둥글게 만들기
```swift
// InterestHomeCollectionViewCell.swift
override func layoutSubviews() {
    super.layoutSubviews()
    
    self.layer.cornerRadius = 10.0
    self.clipsToBounds = true
}
```
- `self.imageView.layer.corenrRadius`로도 가능하지만 `UIVisualEffectView`도 처리를 해줘야하기 때문에 한번에 처리해주기 위해 `CollectionViewCell`를 설정해줬다.
