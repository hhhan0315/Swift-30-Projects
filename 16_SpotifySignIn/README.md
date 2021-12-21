# 스크린샷
![16](https://github.com/hhhan0315/Swift-30-Projects/blob/main/16_SpotifySignIn/16.gif)

# 미디어 처리

- `AVFoundation` : 미디어 아이템에 대해 재생, 생산에 사용

<br>

```swift
var videoLooper: AVPlayerLooper!

func playVideo() {
    guard let path = Bundle.main.path(forResource: "moments", ofType: "mp4") else { return }
    let url = URL(fileURLWithPath: path)
    
    let playerItem = AVPlayerItem(url: url)
    let queuePlayer = AVQueuePlayer(playerItem: playerItem)
    videoLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)

    let playerLayer = AVPlayerLayer(player: queuePlayer)
    playerLayer.frame = self.view.bounds
    playerLayer.videoGravity = .resizeAspectFill
    self.videoView.layer.addSublayer(playerLayer)
    
    queuePlayer.play()
    
    self.videoView.bringSubviewToFront(logoImageView)
    self.videoView.bringSubviewToFront(stackView)
}
```

- `AVPlayerLooper`가 자동으로 반복을 관리
- `bringSubViewToFront` : 가려진 뷰들을 앞으로 가져옴
