//
//  XCUIElement.swift
//  WeatherUITests
//
//  Created by Hoang Thi on 14/06/2022.
//

import XCTest

extension XCUIElement {
    func scrollToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }

    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
    
    func clearText() {
            guard let stringValue = self.value as? String else {
                return
            }

            var deleteString = String()
            for _ in stringValue {
                deleteString += XCUIKeyboardKey.delete.rawValue
            }
            typeText(deleteString)
        }
}
