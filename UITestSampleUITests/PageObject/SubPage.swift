//
//  SubPage.swift
//  UITestSampleUITests
//
//  Created by mozkzki on 2023/01/13.
//  Copyright © 2023 mozksoft. All rights reserved.
//

import XCTest

final class SubPage: PageObjectable {
    enum A11y {
        static let pageTitle = "SubViewController-textView"
        static let button = "SubViewController-button"
        static let displayLabel = "SubViewController-label"
        static let sheetTitle = "タイトルです"
        static let sheetAction1 = "アクション 1"
        static let sheetAction2 = "アクション 2"
        static let cancelAction = "キャンセル"
    }

    var pageTitle: XCUIElement {
        return app.textViews[A11y.pageTitle].firstMatch
    }

    private var button: XCUIElement {
        return app.buttons[A11y.button].firstMatch
    }

    var displayLabel: XCUIElement {
        return app.staticTexts[A11y.displayLabel].firstMatch
    }

    var sheetTitle: XCUIElement {
        // - [【iOS】iOS 16でのUITestで気づいた「これまでと違う点」 · Yoshi's Notes](https://blog.sato0123.com/2022/09/10/UITest_on_iOS16/)
        // iOS16からapp.sheets["xxxxx"]でのアクセスができなくなり、scrollViews経由で取る必要がある
        return app.scrollViews.staticTexts[A11y.sheetTitle].firstMatch
    }

    private var sheetAction1: XCUIElement {
        return app.buttons[A11y.sheetAction1].firstMatch
    }

    private var sheetAction2: XCUIElement {
        return app.buttons[A11y.sheetAction2].firstMatch
    }

    private var cancelAction: XCUIElement {
        return app.buttons[A11y.cancelAction].firstMatch
    }

    @discardableResult
    func openActionSheet() -> SubPage {
        _ = button.waitForExistence(timeout: 5)
        button.tap()
        return self
    }

    @discardableResult
    func action1() -> SubPage {
        _ = sheetAction1.waitForExistence(timeout: 5)
        sheetAction1.tap()
        return self
    }

    @discardableResult
    func action2() -> SubPage {
        _ = sheetAction2.waitForExistence(timeout: 5)
        sheetAction2.tap()
        return self
    }

    @discardableResult
    func cancel() -> SubPage {
        _ = cancelAction.waitForExistence(timeout: 5)
        cancelAction.tap()
        return self
    }
}
