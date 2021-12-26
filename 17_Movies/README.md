# 스크린샷
![17](https://github.com/hhhan0315/Swift-30-Projects/blob/main/17_Movies/17.gif)

# The MovieDB ApI

- 원본 `plist` 파일의 사진 링크가 현재는 동작하지 않았다.
- https://www.themoviedb.org 에서 `API`를 활용하는 것으로 수정했다.

# 객체 간 비동기 데이터 전송

> 참고 : https://hcn1519.github.io/articles/2017-08/iOS_DataPassingBetweenClass

- 클로저 활용
- `NetworkManager` 클래스에서 비동기 데이터 전송 활용
- `ImageDownloader` 클래스는 동기적으로 데이터 전송

```swift
// ImageDownloader
guard let imageData = try? Data(contentsOf: url) else { return }
```

# 과정

> 참고 : https://www.raywenderlich.com/5293-operation-and-operationqueue-tutorial-in-swift

- 처음에 `GCD`를 활용해서 구현했다.
- 무작위로 이미지가 나타나서 원하는 방향이 아니었다.

|workflow 1|workflow 2|
|--|--|
|![work1](https://github.com/hhhan0315/Swift-30-Projects/blob/main/17_Movies/workflow1.png)|![work2](https://github.com/hhhan0315/Swift-30-Projects/blob/main/17_Movies/workflow2.png)|

- 해당 workflow처럼 하려면 `Operation`, `Operation Queue` 가 적합하다고 생각한다.

## Operation

> 참고 : https://www.inflearn.com/course/iOS-Concurrency-GCD-Operation/dashboard

- GCD 기반이며 `취소`, `순서지정`, `일시중지` 등의 기능을 추가로 가지고 있다.
- 작업을 클래스화 (데이터 다운, 이미지 필터 적용)
- 기본적으로 `동기적`
- 인스턴스화 -> 작업 한번 실행 (다시 실행하려면 다시 인스턴스화)
- `start()` : 동작하는 메서드가 있지만 보통 `Operation Queue` 사용
- 상태 체크 변수 : `isReady`, `isExecuting`, `isCancelled`, `isFinished`
- 상태 체크 변수로 오퍼레이션 큐가 순서를 지정하거나 취소할 수 있다.
- `input` -> `main() 재정의` -> `output`


- 비동기 함수를 `Operation`으로 감싸면 순서 설정이 가능하다.
- 영화정보 URL -> 다운로드
- Operation : 영화 포스토 URL -> `다운로드` -> 이미지 -> `이미지 필터 적용`


## 순서
- 영화정보 URL에 따라 데이터를 다운받으면 `MovieRecord`를 인스턴스화 후 배열에 저장 (NetworkManager 비동기 데이터 전송)
- TableView cell을 만들 때 `MovieRecord`의 `State`에 따라 동기적으로 Operation 실행
- `new` 상태
  - 다운로드 오퍼레이션 추적을 위한 `downloadsInProgress` 딕셔너리 존재
  - `Operation Queue` 생성 후 이름 지정하면 디버거에 이름 표시
  - `maxConcurrentOperationCount`를 1로 설정하여 하나씩 완료하도록 설정
- `downloaded` 상태
  - 위와 동일하게 `filterInProgress` 존재
- `addOperation()` 으로 작업 실행


- 스크롤이 진행되지 않을 때 동작하도록 기능 추가
