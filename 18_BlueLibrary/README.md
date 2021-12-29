# 스크린샷
![18](https://github.com/hhhan0315/Swift-30-Projects/blob/main/18_BlueLibrary/18.gif)


> 참고 : https://www.raywenderlich.com/477-design-patterns-on-ios-using-swift-part-1-2
> 
> 참고 : https://www.raywenderlich.com/476-design-patterns-on-ios-using-swift-part-2-2
> 
> 목표 : 따라해보면서 패턴에 대해 이해

# Tool bar, Tab bar

- `Tool bar` : 현재 보여지고 있는 내용과 연관된 액션을 수행
- `Tab bar` : 앱의 여러 섹션 간의 전환
- 현재 프로젝트에서는 `Tool bar`

```swift
// Tool bar 설정
private func setNavigationController() {
    self.navigationController?.isToolbarHidden = false
    let undoButton = UIBarButtonItem(systemItem: .undo)
    let flexSpace = UIBarButtonItem(systemItem: .flexibleSpace)
    let trashButton = UIBarButtonItem(systemItem: .trash)
    self.setToolbarItems([undoButton, flexSpace, trashButton], animated: true)
    //  self.navigationController?.setToolbarItems([undoButton], animated: true)
    // 특이하게 navigationController에 설정하면 나타나지 않는다.
}
```

# Singleton Pattern

- 객체의 인스턴스가 오직 `1개`
- 하나만 생성해서 공용으로 사용하고 싶을 때 사용하는 패턴

```swift
final class LibraryAPI {
    static let shared = LibraryAPI()
    
    private init() { }
}
```

# Facade Pattern

- 어떤 소프트웨어의 커다란 부분에 대하여 간략화된 인터페이스를 제공

```swift
final class LibraryAPI {
    static let shared = LibraryAPI()
    
    private let persistencyManager = PersistencyManager()
    private let httpClient = HTTPClient()
    private let isOnline = false
    
    private init() { }
    
    func getAlbums() -> [Album] {
        return persistencyManager.getAlbums()
    }
    
    func addAlbum(_ album: Album, at index: Int) {
        persistencyManager.addAlbum(album, at: index)
        if isOnline {
            // httpClient.postRequest()
        }
    }
    
    func deleteAlbum(at index: Int) {
        persistencyManager.deleteAlbum(at: index)
        if isOnline {
        }
    }
}
```

- 외부에서는 `addAlbum()` 사용할 때 내부의 복잡한 부분을 알지못하고 알 필요도 없다.


# Decorator Pattern

- 코드를 수정하지 않고 객체에 동작과 책임을 추가한다.
- `Swift` : `Extensions`, `Delegate`
- `Delegate`는 `TableView DataSource`

```swift
// Album.swift
typealias AlbumData = (title: String, value: String)

extension Album {
    var tableRepresentation: [AlbumData] {
        return [
            ("Artist", artist),
            ("Title", title),
            ("Genre", genre),
            ("Year", year),
        ]
    }
}
```

- 테이블뷰 나타낼 때 `tableRepresentation`으로 사용하는 것이 또 다른 방법이었다.
- `title` : `textLabel`에 사용
- `value` : `detailTextLabel`에 사용

# Adapter Pattern

- 서로 다른 인터페이스를 함께 사용
 

# Observer Pattern

- 상태 변경을 알림
- Model과 View 통신을 허용하고 싶지만 직접적인 참조를 할 수말고 해당 패턴 사용

## Notifications

```swift
// AlbumView.swift
// 이벤트 송신
NotificationCenter.default.post(name: .BLDownloadImage, object: self, userInfo: ["imageView": coverImageView ?? UIImage(), "coverUrl" : coverUrl])

// LibraryAPI.swift
// 이벤트 수신 -> downloadImage() 진행
NotificationCenter.default.addObserver(self, selector: #selector(downloadImage(_:)), name: .BLDownloadImage, object: nil)
```

## KVO

- 특정 키의 값의 변화를 감지하는 기능

```swift
// image가 새롭게 바뀔 때 indicatorView를 멈춤
valueObservation = coverImageView.observe(\.image, options: [.new]) { [unowned self] observed, change in
  if change.newValue is UIImage {
    self.indicatorView.stopAnimating()
  }
}
```

# Memento Pattern

- 캡슐화를 위반하지 않고 객체의 이전 상태를 저장하고 복원할 수 있는 패턴
