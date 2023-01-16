//
//  MainPage.swift
//  UITestSampleUITests
//
//  Created by mozkzki on 2023/01/13.
//  Copyright © 2023 mozksoft. All rights reserved.
//

import XCTest

final class MainPage: PageObjectable {

    enum A11y {
        static let pageTitle = "MainViewController-textView"
        static let button = "遷移"
    }

    var pageTitle: XCUIElement {
        return app.staticTexts[A11y.pageTitle].firstMatch
    }

    private var button: XCUIElement {
        return app.buttons[A11y.button].firstMatch
    }

    @discardableResult
    func goToSubPage() -> SubPage {
        _ = button.waitForExistence(timeout: 5)
        button.tap()
        return SubPage()
    }
}
