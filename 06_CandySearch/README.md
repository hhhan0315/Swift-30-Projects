# 스크린샷
![6](https://github.com/hhhan0315/Swift-30-Projects/blob/main/06_CandySearch/6.gif)

참고 : https://www.raywenderlich.com/4363809-uisearchcontroller-tutorial-getting-started#toc-anchor-010

참고 : https://devmjun.github.io/archive/SearchController

# UISearchController
## obscuresBackgroundDuringPresentation
|true|false|
|--|--|
|![true](https://github.com/hhhan0315/Swift-30-Projects/blob/main/06_CandySearch/obscures_true.png)|![false](https://github.com/hhhan0315/Swift-30-Projects/blob/main/06_CandySearch/obscures_false.png)|

- 검색할 때 배경을 흐리게할지 선택

## definesPresentationContext
참고 : https://velog.io/@tksrl0379/Presentation-Styles-Segues
- `currentContext` : Presenting VC인 MasterVC의 컨텐츠만 덮는다.
- `definesPresentationContext` 프로퍼티가 `true`인 VC를의 View를 찾을때까지 탐색한다.
- 찾지못한다면 `Window`의 root VC의 View

```swift
// SceneDelegate.swift
// root View Controller가 navigation Controller
window?.rootViewController = navController

// CandyHomeViewController
override func viewDidLoad() {
    self.definesPresentationContext = false
    self.navigationController?.definesPresentationContext = false
}

extension CandyHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = CandyDetailViewController()
        nextVC.candy = candy
        nextVC.modalPresentationStyle = .currentContext
        self.present(nextVC, animated: true, completion: nil)
    }
}
```

<img src="https://github.com/hhhan0315/Swift-30-Projects/blob/main/06_CandySearch/defines.png" width=300>

- rootViewController가 Navigation Controller라서 Navigation Bar가 남아있다.

# tableFooterView
- `SearchFooterView.swift` 는 [참고링크](https://devmjun.github.io/archive/SearchController) 에서 가져왔다.
- Header, Footer 참고 : https://velog.io/@dvhuni/UITableView-Header-Footer-View-한번에-만들기
```swift
private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.tableFooterView = searchFooterView
    return tableView
}()

private lazy var searchFooterView: SearchFooterView = {
    let searchFooterView = SearchFooterView()
    searchFooterView.translatesAutoresizingMaskIntoConstraints = false
    searchFooterView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 44.0)
    return searchFooterView
}()
```

- 계속 나타나지 않았는데 frame을 지정해주니까 나타났다.

# search Bar 자동 숨김 해제
- `navigationItem.hidesSearchBarWhenScrolling = false`


