# 스크린샷
![19](https://github.com/hhhan0315/Swift-30-Projects/blob/main/19_Pinterest/19.gif)


# class func, static func

> 참고 : https://dev200ok.blogspot.com/2020/09/swift-type-method.html

```swift
class Student {
    func instanceFunc(){
        print("instance func leeo")
    }
    class func classFunc() {
        print("class func leeo")
    }
    static func staticFunc() {
        print("static func leeo")
    }
}

let student = Student()
student.instanceFunc()

Student.classFunc()
Student.staticFunc()
```

- `class`, `static`은 클래스 자체에서 사용하며 공통 부분이라는 것으로 표현
- `class` : 상속 가능
- `static` : 상속 불가능

# UICollectionView custom layout

- 이미지 파일 및 Photos.plist 파일은 참고본과 동일하게 사용

> 참고 : https://www.raywenderlich.com/4829472-uicollectionview-custom-layout-tutorial-pinterest

> 참고 : https://demian-develop.tistory.com/21

## UICollectionViewFlowLayout

- 스크롤의 방향에 따라 가능한 많은 셀을 배치하고 넘어간다.
- `UICollectionViewDelegateFlowLayout`으로 동적으로 사이즈를 지정할 수 있는데 이때 해당 행의 높이는 가장 큰 셀의 크기로 지정한다.
- 원하는 결과물이 아니었다.

## UICollectionViewLayout

1. `prepare()` : 레이아웃 정보 초기 계산 진행
2. `collectionViewContentSize` : `prepare()` 근거로 content 크기 반환
3. `layoutAttributesForElements(in:)` : 사각형 내의 모든 셀과 뷰에 대한 레이아웃 속성 반환

- 따라서 만들어보는 것에 집중
