# 스크린샷
![15](https://github.com/hhhan0315/Swift-30-Projects/blob/main/15_SnapchatMenu/15.gif)

# view frame 설정

- `scrollView`와 `imageView`들의 `width`, `height`를 모두 해당 `view frame`에 맞춰서 설정해줘야 이미지가 올바르게 나타났다.

# Container View 사용법
> 참고 : https://ios-development.tistory.com/228

```swift
let chatVC = ChatViewController()
self.addChild(chatVC)
self.scrollView.addSubview(chatVC.view)
chatVC.didMove(toParent: self)
```

- `부모` 입장에서 설정
- 현재 부모 `ViewController`에 자식 `ChatViewController` 자식으로 설정
- 추가된 `chatVC`의 `view`가 보일 수 있도록 추가
- `chatVC`의 입장에서는 언제 `parentVC`가 추가되는지 모르기 때문에 추가 시점을 알려줌

# 위치 지정

![scrollview](https://github.com/hhhan0315/Swift-30-Projects/blob/main/15_SnapchatMenu/scrollview.png)

- `origin.x`를 해당 `view.frame.width` 크기만큼 설정
- `contentSize` : 스크롤뷰 실제 콘턴츠 영역 크기
- `contentOffset` : 스크롤뷰의 시작점 (0, 0) 에서 두번 째 뷰 컨트롤러부터 보여주기 위해 (view.frame.width, 0) 으로 수정
