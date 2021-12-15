# 스크린샷
![11](https://github.com/hhhan0315/Swift-30-Projects/blob/main/11_Animations/11.gif)

# UIKit Preview
> 참고 : https://fomaios.tistory.com/entry/iOS-UIKit에서-SwiftUI-Preview-사용해보기
```swift
// UIKit+Extension.swift
#if canImport(SwiftUI) && DEBUG
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
```
```swift
import SwiftUI

struct VCPreView:PreviewProvider {
    static var previews: some View {
        AnimationsHomeViewController().toPreview()
    }
}
```

- 사용하고 싶은곳에서 사용한다.
- 코드로 UI를 구성하기 때문에 확인 가능하고 시뮬레이터보다 빠르다.

![preview](https://github.com/hhhan0315/Swift-30-Projects/blob/main/11_Animations/preview.png)

# 애니메이션
## CGAffineTransform

- 뷰의 프레임을 계산하지 않고 2D 그래픽을 그릴 수 있다.
- `translate`, `scale`, `rotate`
- 프레임을 계산하지 않기 때문에 오토레이아웃을 적용해 뒀을 때 잘 동작했다.

## 프레임 변경 애니메이션

- `colorAndFrameChange` 애니메이션
```swift
let firstFrame = self.imageView.frame.insetBy(dx: -40, dy: -40)
let secondFrame = firstFrame.insetBy(dx: 20, dy: 20)
let thirdFrame = secondFrame.insetBy(dx: -10, dy: -10)
colorFrameChange(firstFrame, secondFrame, thirdFrame, UIColor.blue, UIColor.orange, UIColor.gray)

// dx, dy 음수 : bounds 크기 증가
// dx, dy 양수 : bounds 크기 감소
// 오토레이아웃으로 해뒀을 때 정확한 Frame 값이 지정되어 있지 않아서 원하는 동작을 하지 않았다.

imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width / 2, height: view.frame.width / 2)
imageView.center = CGPoint(x: view.frame.midX, y: view.frame.midY)

```

|수정 전|수정 후|
|--|--|
|![frame1](https://github.com/hhhan0315/Swift-30-Projects/blob/main/11_Animations/frame1.gif)|![frame2](https://github.com/hhhan0315/Swift-30-Projects/blob/main/11_Animations/frame2.gif)|

## viewFadeIn 애니메이션

```swift
// 그림 1
imageView.image = UIImage(named: "whatsapp")
// 그림 2
imageView = UIImageView(image: UIImage(named: "whatsapp"))

imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width / 2, height: view.frame.width / 2)
imageView.center = CGPoint(x: view.frame.midX, y: view.frame.midY)
view.addSubview(imageView)
```

- 그냥 `image`에 넣으면 그림1처럼 정확하게 frame이 나타나지 않았다.
- `UIImageView`를 만들어주면 나타났다.

|그림1|그림2|
|--|--|
|![fade1](https://github.com/hhhan0315/Swift-30-Projects/blob/main/11_Animations/fade1.png)|![fade2](https://github.com/hhhan0315/Swift-30-Projects/blob/main/11_Animations/fade2.png)|

## UIBezierPath
> 참고 : https://zeddios.tistory.com/846
