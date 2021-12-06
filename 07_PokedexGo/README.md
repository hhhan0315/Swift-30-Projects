# 스크린샷
![스크린샷1](https://github.com/hhhan0315/Swift-30-Projects/blob/main/07_PokedexGo/스크린샷/스크린샷1.gif)
![스크린샷2](https://github.com/hhhan0315/Swift-30-Projects/blob/main/07_PokedexGo/스크린샷/스크린샷2.gif)
![스크린샷3](https://github.com/hhhan0315/Swift-30-Projects/blob/main/07_PokedexGo/스크린샷/스크린샷3.gif)

# UISplitViewController Tutorial
참고 : https://www.raywenderlich.com/4613809-uisplitviewcontroller-tutorial-getting-started

- `SceneDelegate.swift` 에서 `SplitViewController` 기본 설정
```swift
let pokeMasterVC = PokeMasterViewController()
let pokeDetailVC = PokeDetailViewController()
let masterNavController = UINavigationController(rootViewController: pokeMasterVC)

let splitVC = UISplitViewController()
splitVC.viewControllers = [masterNavController, pokeDetailVC]
```
- `MasterViewController` 에서 테이블 뷰를 추가하고 `Pokemon` 모델의 테스트 데이터를 통해 내용을 채워준다.

# 앱 시작 시 Detail 에 내용 보여주기
```swift
// SceneDelegate.swift
// Master의 Pokemons 중의 첫 번째 전달
let firstPokemon = pokeMasterVC.pokemons.first
pokeDetailVC.pokemon = firstPokemon

// PokeDetailViewController
var pokemon: Pokemon? {
	didSet {
		refreshUI()
	}
}
```

# Master, Detail 연결
참고 : https://terry-some.tistory.com/111
참고 : https://www.youtube.com/watch?v=e4-QBhnHmE4
- `delegate` 를 활용했다.
- view간의 통신을 하고 이벤트처리 로직 처리라서 중요하다.
```swift
// protocol 만들어준다.
protocol PokeSelectionDelegate {
	func pokeSelected(_ newPokemon: Pokemon)
}
```

```swift
// PokeMasterViewController.swift
var delegate: PokeSelectionDelegate?

// tableview를 선택했을 때 delegate 발동
// PokeSelectionDelegate 리모컨을 눌렀다.
extension PokeMasterViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedPokemon = pokemons[indexPath.row]
		delegate?.pokeSelected(selectedPokemon)
	}
}
```

```swift
// PokeDetailViewController.swift
// 수신기의 의미 (위에서 리모컨 누르면 여기서 동작)
extension PokeDetailViewController: PokeSelectionDelegate {
	func pokeSelected(_ newPokemon: Pokemon) {
		pokemon = newPokemon
	}
}
```

```swift
// SceneDelegate.swift
// 리모컨 선 연결의 의미
let pokeMasterVC = PokeMasterViewController()
let pokeDetailVC = PokeDetailViewController()
pokeMasterVC.delegate = pokeDetailVC
```

![delegate](https://github.com/hhhan0315/Swift-30-Projects/blob/main/07_PokedexGo/스크린샷/delegate.gif)

# iPhone에서 showDetail
```swift
// PokeMasterViewController.swift
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	// iPhone에서 동작
	if let detailVC = delegate as? PokeDetailViewController,
	   let detailNavController = detailVC.navigationController {
		splitViewController?.showDetailViewController(detailNavController, sender: nil)
	}
}
```

![detail](https://github.com/hhhan0315/Swift-30-Projects/blob/main/07_PokedexGo/스크린샷/iphone_showdetail.gif)

# iPad Portrait
```swift
// SceneDelegate.swift
let detailVC = (splitVC.viewControllers.last as? UINavigationController)?.topViewController as? PokeDetailViewController

detailVC?.navigationItem.leftItemsSupplementBackButton = true
detailVC?.navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
```
|제스처로만 열기 (기본)|navigation left button으로 열기|
|--|--|
|![portrait1](https://github.com/hhhan0315/Swift-30-Projects/blob/main/07_PokedexGo/스크린샷/portrait1.gif)|![portrait2](https://github.com/hhhan0315/Swift-30-Projects/blob/main/07_PokedexGo/스크린샷/portrait2.gif)|
