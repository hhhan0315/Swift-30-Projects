# 스크린샷
![8](https://github.com/hhhan0315/Swift-30-Projects/blob/main/08_SimpleRSSReader/8.gif)

# RSS
- `Rich Site Summary`
- 뉴스, 블로그 사이트에서 주로 사용하는 콘텐츠 표현 방식
- 자동 수집이 가능해졌으며 사이트 방문 없이 최신 정보들만 골라서 볼 수 있다.
- https://www.apple.com/rss/ 의 https://www.apple.com/newsroom/rss-feed.rss 활용
- `chrome` 으로 열기
- https://codebeautify.org/xmlviewer# 활용

# Parse XML 
참고 : https://www.youtube.com/watch?v=fP69LI5bZlg
## XML
![xml](https://github.com/hhhan0315/Swift-30-Projects/blob/main/08_SimpleRSSReader/xml.png)
## XML Parser
```swift
private var parserCompletionHandler: (([RSSItem]) -> Void)?

// 1. 클로저가 parserFeed() 의 completionHandler 인자로 전달
func parseFeed(url: String, completionHandler: @escaping (([RSSItem]) -> Void)) {
	
  // 2. parserCompletionHandler 변수에 저장
  self.parserCompletionHandler = completionHandler

  let request = URLRequest(url: URL(string: url)!)
  let urlSession = URLSession.shared
  let task = urlSession.dataTask(with: request) { (data, response, error) in
    guard let data = data else {
      if let error = error {
        print(error.localizedDescription)
      }
        return
      }

      let parser = XMLParser(data: data)
      parser.delegate = self
      parser.parse()
    }
  task.resume()
}
// 3. parserFeed() 종료
// 4. 클로저 completionHandler 아직 실행되지 않음
// completionHandler는 함수의 실행이 종료되기 전에 실행되지 않기 때문에 escaping 클로저
// 함수 밖(escaping)에서 실행되는 클로저

// 성공적으로 파싱이 끝났을 때 completionHandler 실행
func parserDidEndDocument(**_** parser: XMLParser) {
  parserCompletionHandler?(rssItems)
}
```
- `url` 로 통신을 한 뒤에 결과값 `data` 를 이용해서 `XMLParser` 객체 생성
- `parse()` 를 통해 파싱 시작
### escaping clousre
참고 : https://jusung.github.io/Escaping-Closure/
- `completionHandler` : 비동기 작업이 끝나는 명확한 시점을 알고 작업을 할 때 필요하다.
- `callback` 함수를 통해서 작업이 끝난 것을 전달받아야 한다. 아니면 항상 `nil` 반환
- 유튜브에서는 `@escaping` 말고 `?` 옵셔널로 처리했다.

## XML Parser Delegate
참고 : https://nsios.tistory.com/38
```swift
func  parser(_  parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])

func  parser(_  parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)  

func  parser(_  parser: XMLParser, foundCharacters string: String)  
```
```
ex) <entry>안녕하세요</entry>
didStartElement elementName : entry
didEndElement elementName : entry
foundCharcters string : 안녕하세요 
```

## XML 태그 뒤에 빈칸 인식
```swift
private var currentTitle: String = "" {
  didSet {
    currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
  }
}
```
- `whitespacesAndNewlines` :  앞 뒤 공백을 제거해준다.

# DateFormatter
참고 : https://formestory.tistory.com/6
```swift
private func makeStringToDateToString(_ dateString: String) -> String {
  // 입력 : 2021-12-06T13:58:12.539Z
  let stringToDateFormatter = DateFormatter()
  stringToDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
  guard let date = stringToDateFormatter.date(from: dateString) else {
    return ""
  }

  let dateToStringFormatter = DateFormatter()
  dateToStringFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
  let resultString = dateToStringFormatter.string(from: date)
  return resultString
}
```

# TableView Cell expand, collapse
- 저번 5번 과제에서는 구조체에 `expanded` 변수를 할당해서 해당 변수에 따라 펼쳐졌는지 아닌지 확인했다.
```swift
enum CellState {
  case expanded
  case collapsed
}
```
- `CellState` `enum` 생성

```swift
// 배열 생성 후 fetchData() 진행할 때 rssItems.count 만큼 채워준다.
private var cellStates: [CellState]?

extension  AppleNewsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell else { return }

    tableView.performBatchUpdates({
    cell.contentsLabel.numberOfLines = cell.contentsLabel.numberOfLines == 2 ? 0 : 2
    cellStates?[indexPath.row] = cell.contentsLabel.numberOfLines == 2 ? .collapsed : .expanded
    }, completion: nil)
  }
}
```
- 클릭할 때 5번 과제에서는 구조체 자체의 변수 값을 변경하고 새로 저장하고 반복했었다.
- 여기서는 `cellStates` 배열의 해당 위치의 값만 바로 변경해주면 되서 훨씬 간단해졌다.
