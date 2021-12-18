# 스크린샷
![12](https://github.com/hhhan0315/Swift-30-Projects/blob/main/Project_12_Tumblr/Simulator%20Screen%20Recording%20-%20iPhone%2011%20-%202021-12-17%20at%2020.10.45.gif)

# overFullScreen, fullScreen

> 참고 : https://onelife2live.tistory.com/34

- `modalPresentationStyle`
- `overFullScreen` : presentingViewController의 view들이 계층에서 사라지지 않으며 배경을 투명하게 하면 보인다.
- `fullScreen` : presentingViewController의 view들이 계층에서 사라지며 배경을 투명하게 해도 보이지 않는다.

|overFullScreen|fullScreen|
|--|--|
|<img src="https://github.com/hhhan0315/Swift-30-Projects/blob/main/Project_12_Tumblr/overfull.png" width=300>|<img src="https://github.com/hhhan0315/Swift-30-Projects/blob/main/Project_12_Tumblr/full.png" width=300>|

# red, green, blue color 지정
```swift
view.backgroundColor = UIColor(red: 19/255, green: 38/255, blue: 102/255, alpha: 1)
```

# Custom Transition Animation

> 참고 : https://www.raywenderlich.com/2925473-ios-animation-tutorial-custom-view-controller-presentation-transitions
> 참고 : https://nsios.tistory.com/43

- 화면 전환 커스텀 애니메이션
- `UIViewControllerAnimatedTransitioning` : ViewController 전환 시 커스템 애니메이션을 주고싶을 때 구현
- `UIViewControllerTransitioningDelegate` : ViewController 간의 전환에 사용되는 delegate
- 컬렉션뷰로 만들어서 해당 컬렉션뷰셀이 등장할 때 애니메이션을 적용하고 싶었지만 `present` 진행할 때 존재하지 않다고 나오기 때문에 적용하지 못했다.
- 원본처럼 이미지뷰와 라벨을 미리 지정해두면 적용할 수 있지않을까 싶다.
