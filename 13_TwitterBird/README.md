# 스크린샷
![13](https://github.com/hhhan0315/Swift-30-Projects/blob/main/13_TwitterBird/13.gif)

# AppDelegate, SceneDelegate

> 참고 : https://velog.io/@dev-lena/iOS-AppDelegate와-SceneDelegate

- iOS 13 부터 바뀜
- `SceneDelegate`가 `UILifeCycle`에 대한 부분을 담당한다.
- `AppDelegate`
  - 데이터 구조 초기화
  - scene 환경 설정
  - 앱 밖에서 발생한 알림 대응
  - push 알림 서비스 실행 시 요구되는 모든 서비스 등록

# mask

- 이미지의 일부만 보여주기 위해 사용
- 트위터 아이콘 이미지만큼만 보여줬다.

# CAKeyframeAnimation

> 참고 : https://wookiphone.tistory.com/81

- 애니메이션을 keyFrame로 쪼개서 각각 효과를 줄 수 있다.
 
# CAAnimationDelegate

- 두 개의 메소드가 존재한다.

```swift
func animationDidStart(_ anim: CAAnimation)
func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
```
