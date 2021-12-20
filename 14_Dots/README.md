# 스크린샷
![14](https://github.com/hhhan0315/Swift-30-Projects/blob/main/14_Dots/14.gif)

# Animation Option
```swift
UIView.animate(withDuration: 0.6, delay: 0.0, options: [.repeat, .autoreverse], animations: {
    self.dotImageView1.transform = .identity
})
```

- `repeat` : 무한 반복
- `autoreverse` : 반대로도 실행
- `identity` : 원래대로 돌아옴
- 처음에 0.9초로 실행해서 0.3초 단위로 나눴지만 살짝 느려보여서 0.6초 실행에 0.2초 간격으로 수정했다.
