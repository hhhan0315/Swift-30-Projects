# 스크린샷
![4](https://github.com/hhhan0315/Swift-30-Projects/blob/main/04_TodoTDD/4.gif)

# TableView Swipe Delete
```swift
func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
}

func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        if PersistenceManager.shared.remove(object: todoData[indexPath.row]) == true {
            updateTodoData()
            tableView.reloadData()
        }
    }
}
```

# 키보드 사라지기
```swift
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    view.endEditing(true)
}
```
- View 어떤 곳이든 터치하면 호출

```swift
extension TodoAddViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
```
- 키보드의 `Return` 클릭 시 호출

# TextField가 비어있지 않을 때 Save 버튼 활성화
```swift
private lazy var titleTextField: UITextField = {
    let textField = UITextField()
    textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    textField.delegate = self
    return textField
}()

@objc func textFieldDidChange(_ textField: UITextField) {
    if checkTextFieldsIsNotEmpty() {
        saveButton.isEnabled = true
        saveButton.setTitleColor(.systemBlue, for: .normal)
    } else {
        saveButton.isEnabled = false
        saveButton.setTitleColor(.lightGray, for: .normal)
    }
}

func checkTextFieldsIsNotEmpty() -> Bool {
    guard let titleText = titleTextField.text else { return false }
    guard let addressText = addressTextField.text else { return false }
    guard let descText = descTextField.text else { return false }
    if titleText.isEmpty || addressText.isEmpty || descText.isEmpty {
        return false
    } else {
        return true
    }
}
```

# Core Data 활용으로 데이터 저장
참고 : [zeddios - Core Data](https://zeddios.tistory.com/987)
- `PersistenceManager` 를 활용해 불러오기, 저장, 삭제
- `Todo` 구조체는 데이터 전달을 위해서만 이용
- 원본에는 네트워크를 사용했는데 Core Data를 사용

# UITest
![uitest](https://github.com/hhhan0315/Swift-30-Projects/blob/main/04_TodoTDD/4_uitest.gif)
- 직접 입력했을 때 시간이 오래걸렸는데 상당히 유용했다.
