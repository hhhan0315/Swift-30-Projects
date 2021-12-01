# 스크린샷
![5](https://github.com/hhhan0315/Swift-30-Projects/blob/main/05_Artistry/5.gif)

# json 파일 불러오기
참고 : https://jiseobkim.github.io/swift/network/2021/05/16/swift-JSON-파일-불러오기.html
- `artists.json`와 `이미지 파일`은 원본 프로젝트에서 복사
- json 파일 형식에 맞춰서 `ArtistsJson.swift`, `Artist.swift`, `Work.swift` 파일 생성

```swift
struct ArtistsJson: Codable {
    let artists: [Artist]
    
    static func jsonFromBundle() -> ArtistsJson? {
        let fileName = "artists"
        let extensionType = "json"
        
        guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: extensionType) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            let artistsJson = try? JSONDecoder().decode(ArtistsJson.self, from: data)
            return artistsJson
        } catch {
            return nil
        }
    }
}
```

```swift
struct Artist: Codable {
    let name: String
    let bio: String
    let image: String
    var works: [Work]
}
```

```swift
struct Work: Codable {
    let title: String
    let image: String
    let info: String
}
```

# ⭐️ Self sizing Table View Cell
- 이번 프로젝트의 가장 중요한 목표
- 우선 이번 프로젝트도 storyboard 사용 없이 코드로만 모두 작성하는 것으로 시작했다.
- 기본 특성인 `textLabel`에 `numberOfLines = 0` 설정을 변경해주면 dynamic 하게 잘 동작했다.
- 하지만 custom으로 `Label` 생성 후에 `numberOfLines = 0` 해도 동작하지 않았다.

<br>

- 참고 : https://doorganizedcoding.tistory.com/entry/UITableViewCell-Self-Sizing-Not-Work?category=711638?category=711638
- 참고 : https://www.youtube.com/watch?v=Z_aJWjarRpg
- 참고 링크를 보면서 `interface builder`를 활용하면서 설명을 대부분 하고 있었고 심지어 원본 프로젝트 참고 링크에도 마찬가지였다.
- 그래서 유튜브 참고 링크를 활용해 `ArtistTableViewCell.xib`, `WorkTableViewCell.xib` 를 만들어서 해결하고자 했다.

```swift
class ArtistTableViewCell: UITableViewCell {

    static let identifier = "ArtistCell"
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
```
|xib 파일|실행 모습|
|--|--|
|![cell1](https://github.com/hhhan0315/Swift-30-Projects/blob/main/05_Artistry/cell1.png)|![cell2](https://github.com/hhhan0315/Swift-30-Projects/blob/main/05_Artistry/cell2.png)|

- `NameLabel.bottom <= bottomMargin` : 해당 조건만 적었을 때 경고 발생
- `NameLabel.bottom = bottomMargin @250` : priority 우선순위를 낮춰서 조건 하나를 더 추가해주니까 경고 해결

# 테이블뷰 구분선 색 조정 및 왼쪽 공백 제거
```swift
private lazy var tableView: UITableView = {
    let tableView = UITableView()
    
    // 테이블뷰에 xib 파일 등록
    let cellNib = UINib(nibName: String(describing: ArtistTableViewCell.self), bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: ArtistTableViewCell.identifier)
    
    // true : 충돌을 일으키지 않고 크기, 위치를 수정하기 위해 constraint를 추가할 수 없다.
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.dataSource = self
    tableView.delegate = self
    
    // 테이블뷰 높이 유동적으로 설정
    tableView.rowHeight = UITableView.automaticDimension
    // 개발자가 예상하는 테이블뷰 높이
    tableView.estimatedRowHeight = 120
    
    // 구분선 색 조정 및 공백 제거
    tableView.separatorColor = .darkGray
    tableView.separatorInset.left = 0
    tableView.separatorInset.right = 0
    
    tableView.tableFooterView = UIView()
    return tableView
}()
```

# Codable에 지정 키가 없는 경우
- 위의 `Work.swift` 를 잘 만들었다.
- 하지만 기능 중에 테이블 뷰를 클릭할 때마다 그림의 설명을 펼쳤다가 접었다가 해줘야 했다.
- 각 그림은 Work 구조체에 정보가 저장되는데 json 파일에는 `expanded` 라는 정보가 없기 때문에 그냥 불러오려하면 불러와지지 않았다.

```swift
struct Work: Codable {
    let title: String
    let image: String
    let info: String
    var expanded: Bool?
}
```
- 처음에는 옵셔널처리만 해줌으로써 해결할 수 있었지만 기본값이 `nil` 이기 때문에 `true`, `false`로 동작해주기 위해서 제한이 있었다.

```swift
struct Work: Codable {
    let title: String
    let image: String
    let info: String
    var expanded: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(String.self, forKey: .image)
        info = try container.decode(String.self, forKey: .info)
        expanded = (try? container.decodeIfPresent(Bool.self, forKey: .expanded)) ?? false
    }
}
```
- 참고 : https://jiseobkim.github.io/swift/network/2021/05/30/swift-Codable-Throw-처리-(feat.-CodingKey).html
- 참고해서 값이 없을 경우 `false`값을 넣어줬다.

# tableView 행 높이 변경
![height](https://github.com/hhhan0315/Swift-30-Projects/blob/main/05_Artistry/height.gif)

- 클릭했을 경우 `expanded` 의 `true`, `false` 에 따라 달라진다.
```swift
extension ArtistDetailListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? WorkTableViewCell else {
            return
        }
        
        guard let artistCopy = artist else { return }
        
        var work = artistCopy.works[indexPath.row]
        work.expanded = !work.expanded
        
        // 기존값에 저장
        artist?.works[indexPath.row] = work

        tableView.performBatchUpdates({
            cell.infoLabel.text = work.expanded ? work.info : selectMore
        }, completion: nil)
        
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
```
- cell을 `reloading`하지 않고 변경 가능
- `beginUpdates()`, `endUpdates()`로도 가능하다.
- 참고 : https://yoojin99.github.io/app/UITableView-PerformBatchUpdates/
