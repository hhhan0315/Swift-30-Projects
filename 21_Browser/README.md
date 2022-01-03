# 스크린샷
![21](https://github.com/hhhan0315/Swift-30-Projects/blob/main/21_Browser/21.gif)

# WKWebView Back, Forward Button

> 참고 : https://zeddios.tistory.com/374

```swift
extension MainViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}
```

- `didFinish`는 다른곳으로 이동할 때 호출
- 앞/뒤로 이동 가능할 때만 활성화

# WKWebView Progress View URL 로딩

> 참고 : https://sosoingkr.tistory.com/20

- `KVO` : Key Value Observing
- Key가 Value 변경을 감시

```swift
// 이벤트 수신 설정
webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

// 값 감시
override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
        progressView.progress = Float(webView.estimatedProgress)
        progressView.isHidden = (webView.estimatedProgress == 1)
    }
}
```
