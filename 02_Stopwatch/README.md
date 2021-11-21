# 스크린샷
![2](https://github.com/hhhan0315/Swift-30-Projects/blob/main/02_Stopwatch/2.gif)

# navigation Bar 제목 설정
```swift
navigationController.navigationBar.topItem?.title = "Stopwatch"
```

# TableViewCell 파일 생성 및 설정
```swift
class LapTableViewCell: UITableViewCell {

    static let identifier = "LapCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// ViewController viewDidLoad
tableView.register(LapTableViewCell.self, forCellReuseIdentifier: LapTableViewCell.identifier)
```
- 여기서 style을 `.value1`로 변경해줄 수 있다.

# Timer 설정
```swift
totalStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(updateTotalTimer), userInfo: nil, repeats: true)

// 여기서 원본은 RunLoop에도 추가
RunLoop.current.add(lapStopwatch.timer, forMode: RunLoop.Mode.common)

// 원본 weakSelf로 선언 후 timer target에 대입
unowned let weakSelf = self
```
- Timer.scheduledTimer 는 기본적으로 run loop에 자동 예약이다.
- UI와 상호작용하는 경우 타이머가 실행하지 않을 수 있다.
- 이때 수동으로 예약을 해줘서 문제를 해결해줄 수 있다.
- 강한 참조를 벗어나기 위해 `unowned`, `weak`를 사용한다고 알고있다.
