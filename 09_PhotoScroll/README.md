# 스크린샷
![9](https://github.com/hhhan0315/Swift-30-Projects/blob/main/09_PhotoScroll/9.gif)

# UICollectionView
> 참고 : https://velog.io/@panther222128/UICollectionView-Programmatically-Practice
- `UITableView`, `UITableViewCell`를 사용하는 것과 비슷했다.
- 큰 차이점은 그냥 `UICollectionView()`로 선언하면 오류가 발생한다.
- 아래와 같이 초기화를 정확하게 해줘야 한다.
- `UICollectionViewFlowLayout` : `UICollectionViewLayout`의 하나의 유형이며 애플에서 권장한다.
- `UICollectionViewLayout()`을 사용했을 때 컬렉션뷰셀이 나타나지 않았다.

```swift
private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return collectionView
}()

// 셀의 크기를 결정
extension PhotoMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / 5
        return CGSize(width: size, height: size)
    }
}
```

<img src="https://github.com/hhhan0315/Swift-30-Projects/blob/main/09_PhotoScroll/collectionview.png" width=300>

# UIScrollView 안에 UIImageView Zoom
> 참고 : https://www.raywenderlich.com/5758454-uiscrollview-tutorial-getting-started
- `UIScrollView`는 `view`와 오토 레이아웃
- `UIImageView`는 `UIScrollView`와 오토 레이아웃
```swift
class PhotoDetailViewController: UIViewController {
    
    var photoImageName: String? {
        didSet {
            guard let photoImageName = photoImageName else { return }
            let image = UIImage(named: photoImageName)
            let width = image?.size.width ?? 0
            let height = image?.size.height ?? 0
            mainImageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            mainImageView.image = image
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }

    private func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / mainImageView.bounds.width
        let heightScale = size.height / mainImageView.bounds.height
        let minScale = min(widthScale, heightScale)

        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
}

extension PhotoDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mainImageView
    }
}
```

- 이미지 크기가 본래 이미지 크기처럼 크게 나타났다. (*그림1*)
- `zoomScale`이 `default`가 1.0인데 이걸 수정해줌으로써 이미지뷰가 화면에서 벗어나지 않기로 해주고 싶었다.
- 코드로 작성하니까 `mainImageView.bounds.width`, `mainImageView.bounds.height`가 `0.0`이다.
- `photoImageName`을 전달받을 때 해당 이미지의 `width`, `height`로 `mainImageView`의 `frame`을 새로 지정해주니까 이미지가 벗어나지 않고 나타났다. (*그림2*)
- `viewForZooming` : 스크롤뷰에서 핀치 줌이 발생했을 때 어떤 뷰를 확대/축소가 할지 정해주는 것
- `viewWillLayoutSubviews()` : `view`의 `bounds`가 최종적으로 결정되는 최초 시점

|그림1|그림2|
|--|--|
|![zoom1](https://github.com/hhhan0315/Swift-30-Projects/blob/main/09_PhotoScroll/zoom1.png)|![zoom2](https://github.com/hhhan0315/Swift-30-Projects/blob/main/09_PhotoScroll/zoom2.png)|

# 이미지뷰 가운데로 맞추기
- `storyboard`에서는 상태바, 네비게이션바를 view가 겹치고 있지 않는 것 같다.
- 코드로 작성했을 때와 `view.bounds.size`가 다르다.
```swift
private func updateConstraintsForSize(_ size: CGSize) {
    let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
    let bottomPadding = view.window?.safeAreaInsets.bottom ?? 0
    let height = size.height - mainImageView.frame.height - statusBarHeight - navigationBarHeight - bottomPadding
    
    let yOffset = max(0, height / 2)
    topConstraint?.constant = yOffset
    bottomConstraint?.constant = yOffset
    
    let xOffset = max(0, (size.width - mainImageView.frame.width) / 2)
    leadingConstraint?.constant = xOffset
    trailingConstraint?.constant = xOffset
    
    view.layoutIfNeeded()
}

extension PhotoDetailViewController: UIScrollViewDelegate {
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
}
```
- 코드로 작성 시 `view`가 항상 전체 화면을 차지한다.
- `상태바 높이`, `네비게이션바 높이`, `Safe Bottom Padding`을 생각해서 계산했다.

|그림1|그림2|
|--|--|
|![center1](https://github.com/hhhan0315/Swift-30-Projects/blob/main/09_PhotoScroll/center1.png)|![center2](https://github.com/hhhan0315/Swift-30-Projects/blob/main/09_PhotoScroll/center2.png)|

# 키보드 나타날 때 화면 올리기
```swift
private func addNotification() {
    NotificationCenter.default.addObserver(
        self,
        selector: #selector(keyboardWillShow(_:)),
        name: UIResponder.keyboardWillShowNotification,
        object: nil)
    
    NotificationCenter.default.addObserver(
        self,
        selector: #selector(keyboardWillHide(_:)),
        name: UIResponder.keyboardWillHideNotification,
        object: nil)
}

private func removeNotification() {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
}

private func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
    guard let userInfo = notification.userInfo,
          let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
        return
    }
    
    let adjustmentHeight = (keyboardFrame.cgRectValue.height + 20) * (show ? 1 : -1)
    scrollView.contentInset.bottom += adjustmentHeight
    scrollView.verticalScrollIndicatorInsets.bottom += adjustmentHeight
}

@objc func keyboardWillShow(_ notification: Notification) {
    adjustInsetForKeyboardShow(true, notification: notification)
}

@objc func keyboardWillHide(_ notification: Notification) {
    adjustInsetForKeyboardShow(false, notification: notification)
}
```
- 이상하게 처음 실행했을 때는 `show`가 두번 동작한다.
- 다시 접근했을 때 올바르게 동작한다.

<img src="https://github.com/hhhan0315/Swift-30-Projects/blob/main/09_PhotoScroll/keyboard.gif" width=300>

# UIPageScrollViewController
## 동작 방식
- `PhotoMainViewController` 첫 실행
- `collectionView` 클릭
- `ManagePageViewController`로 `navigation controller` `push`
- `ManagePageViewController`는  `PhotoDetailViewController`를 나타나도록 하며 `index`에 따라 사진의 이미지가 달라진다.
- `PhotoDetailViewController`의 `imageView`를 클릭하면 `PhotoZoomViewController`를 모달로 나타낸다.

## page indicator
```swift
extension ManagePageViewController: UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return photoImageNames.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex ?? 0
    }
}
```

# imageView 클릭 시 뷰 이동
- `imageView`에 `isUserInteractionEnabled = true` 설정


