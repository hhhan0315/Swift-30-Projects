//
//  _4_TodoTDDUITests.swift
//  04_TodoTDDUITests
//
//  Created by rae on 2021/11/25.
//

import XCTest

class _4_TodoTDDUITests: XCTestCase {
    
    // 테스트가 실행되기 전에 호출
    override func setUpWithError() throws {
        // 오류가 발생해도 계속할까요?
        continueAfterFailure = false
        
        // 앱 실행
        XCUIApplication().launch()
    }
    
    // 테스트가 실행되고 나서 호출
    override func tearDownWithError() throws {
    }
    
    func testTodo() {
        
        let app = XCUIApplication()
        app.navigationBars["_4_TodoTDD.TodoHomeView"].buttons["Add"].tap()
        
        let titleTextField = app.textFields["Title"]
        if titleTextField.isFocused == false {
            titleTextField.tap()
        }
        
        titleTextField.typeText("Study")
        
        let addressTextField = app.textFields["Address"]
        addressTextField.tap()
        addressTextField.typeText("Geolpo-dong, Gimpo-si, Gyeonggi-do")
        
        let descTextField = app.textFields["Description"]
        descTextField.tap()
        descTextField.typeText("Don't sleep")
        
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "March")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "15")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2023")
        
        app.keyboards.buttons["return"].tap()
        app.buttons["Save"].tap()
        
        // 테이블뷰에서 해당 텍스트가 있는지 확인
        XCTAssertTrue(app.tables.staticTexts["Study"].exists)
        XCTAssertTrue(app.tables.staticTexts["Geolpo-dong, Gimpo-si, Gyeonggi-do"].exists)
        XCTAssertTrue(app.tables.staticTexts["15/03/2023"].exists)
        
        let tablesQuery = app.tables.cells
        tablesQuery.element(boundBy: 0).swipeLeft()
        tablesQuery.element(boundBy: 0).buttons["Delete"].tap()
    }
}

// hardware keyboard 해제했는데도 오류나서 넣어둠
extension XCUIElement {
    var isFocused: Bool {
        let isFocused = (self.value(forKey: "hasKeyboardFocus") as? Bool) ?? false
        return isFocused
    }
}
