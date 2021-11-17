# 스크린샷
![1](https://github.com/hhhan0315/Swift-30-Projects/blob/main/01_GoodAsOldPhones/1.gif)

# 스토리보드 삭제 및 SceneDelegate 설정
```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(frame: UIScreen.main.bounds)
        
    let productsVC = ProductsViewController()
    let navController = UINavigationController(rootViewController: productsVC)
    navController.tabBarItem = UITabBarItem(title: "Products", image: nil, tag: 0)
        
    let usVC = UsViewController()
    usVC.tabBarItem = UITabBarItem(title: "Us", image: nil, tag: 1)
        
    let tabBarController = UITabBarController()
    tabBarController.setViewControllers([navController, usVC], animated: false)
        
    window?.rootViewController = tabBarController
    window?.makeKeyAndVisible()
    window?.windowScene = windowScene
}
```
- `LaunchScreen.storyboard`도 삭제하려고 했지만 오류가 발생했다.

# UITableViewDataSource 파일 분리
- `UITableViewDelegate`도 분리해주려고 했지만 `navigationController.pushViewController()`를 사용하기 위해 `extension`으로 구현했다.

# ScrollView 코드 구현
```swift
func setupScrollView() {
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)

    NSLayoutConstraint.activate([
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
        scrollView.topAnchor.constraint(equalTo: view.topAnchor),
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
        contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
        contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
        contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
        contentView.heightAnchor.constraint(equalToConstant: 1000)
    ])
}
```
- `scrollView.topAnchor`로 해줄 때 제대로 동작하지 않았다.
- 높이를 1000으로 지정해줘서 이미지뷰의 높이를 정해놓지 않아서 임의로 커졌다.
