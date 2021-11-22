# 스크린샷
![3](https://github.com/hhhan0315/Swift-30-Projects/blob/main/03_FacebookMe/3.gif)

# UIColor(hex:) 활용
https://cocoacasts.com/from-hex-to-uicolor-and-back-in-swift
```swift
extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
```

# TableView 데이터 배열로 생성
<img src="https://github.com/hhhan0315/Swift-30-Projects/blob/main/03_FacebookMe/33.png" width="300" >

```swift
// 예시
[
    TableKeys.Section: "FAVORITES",
    TableKeys.Rows: [
        [TableKeys.ImageName: "fb_placeholder",TableKeys.Title: TableKeys.addFavorites]
    ]
],
[
    TableKeys.Rows: [
        [TableKeys.ImageName: "fb_settings", TableKeys.Title: "Settings"],
        [TableKeys.ImageName: "fb_privacy_shortcuts", TableKeys.Title: "Privacy Shortcuts"],
        [TableKeys.ImageName: "fb_help_and_support", TableKeys.Title: "Help and Support"]
    ]
],
```

# TableView Style
|plain|grouped|incestGrouped|
|--|--|--|
|![plain](https://github.com/hhhan0315/Swift-30-Projects/blob/main/03_FacebookMe/plain.png)|![grouped](https://github.com/hhhan0315/Swift-30-Projects/blob/main/03_FacebookMe/grouped.png)|![incest](https://github.com/hhhan0315/Swift-30-Projects/blob/main/03_FacebookMe/incestgrouped.png)|

# User에 따라 새로운 Cell 설정
```swift
let cell = UITableViewCell()
let userName = "BayMax"
        
if title == userName {
    cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: nil)
} else {
    cell = tableView.dequeueReusableCell(withIdentifier: FacebookTableViewCell.identifier, for: indexPath)
}
```
