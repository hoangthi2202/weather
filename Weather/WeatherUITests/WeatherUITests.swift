//
//  WeatherUITests.swift
//  WeatherUITests
//
//  Created by Hoang Thi on 11/06/2022.
//

import XCTest

class WeatherUITests: XCTestCase {
    
    let app = XCUIApplication()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUISearch() throws {
        launchApp()
        trySearchSuccessCase()
        tryHideKeyboardByScroll()
        tryPullTpRefresh()
        trySearchFailedCase()
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}

extension WeatherUITests {
    private func launchApp() {
        app.launch()
    }
    
    private func trySearchSuccessCase() {
        // Focus on search bar and type 'saigon'
        let textField = app.searchFields["City name"]
        textField.tap()
        XCTAssert(app.keyboards.count > 0, "Keyboard is not showed")
        textField.typeText("saigon")
        sleep(5)
        XCTAssert(app.tables.cells.count > 0, "Not found weather")
    }
    
    private func tryHideKeyboardByScroll() {
        // Scroll to hide keyboard
        if app.tables.cells.count > 8 {
            let table = app.tables.element(boundBy: 0)
            table.swipeDown()
            
            XCTAssert(app.keyboards.count == 0, "Scroll table but not close keyboard")
        }
    }
    
    private func trySearchFailedCase() {
        // Type another text
        let textField = app.searchFields["City name"]
        textField.tap()
        textField.clearText()
        textField.typeText("saigo1111xxxx")
        sleep(5)
        XCTAssert(app.tables.cells.count == 0, "This search result must empty")
    }
    
    private func tryPullTpRefresh() {
        // Scroll to hide keyboard
        if app.tables.cells.count > 8 {
            let table = app.tables.element(boundBy: 0)
            table.swipeDown(velocity: .fast)
            
            XCTAssert(app.keyboards.count == 0, "Scroll table but not close keyboard")
        }
    }
}
