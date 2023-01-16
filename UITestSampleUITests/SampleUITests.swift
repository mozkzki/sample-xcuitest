//
//  UITestSampleUITests.swift
//  UITestSample
//
//  Created by mozkzki on 2023/01/13.
//  Copyright © 2023 mozksoft. All rights reserved.
//

import XCTest

class SampleUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        print("setup")
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        print("teardown")
    }

    func testメインページのテスト() {
        XCTContext.runActivity(named: "サブページに遷移できること") { _ in
            let subPage = MainPage().goToSubPage()
            XCTAssert(subPage.exists, "SubPage is not displayed")
        }
    }

    func testサブページのテスト() {
        let subPage = MainPage().goToSubPage()

        XCTContext.runActivity(named: "初期表示") { _ in
            XCTContext.runActivity(named: "TextViewの文言が正しいこと") { _ in
                XCTAssertEqual(subPage.pageTitle.value as? String, "XCUITestのサンプル\n(sub view)")
            }
        }

        XCTContext.runActivity(named: "ActionSheetの動作") { _ in
            XCTContext.runActivity(named: "ボタンを押すとActionSheetが開き、正しいタイトルが表示されること") { _ in
                XCTAssertEqual(subPage.openActionSheet().sheetTitle.label, "タイトルです")
            }
            XCTContext.runActivity(named: "アクション 1 ボタンを押すとラベルに正しい文字列が表示されること") { _ in
                XCTAssertEqual(subPage.action1().displayLabel.label, "アクション 1 が押されました")
            }
            XCTContext.runActivity(named: "アクション 2 ボタンを押すとラベルに正しい文字列が表示されること") { _ in
                // ActionSheetが閉じるので再度開く
                XCTAssertEqual(subPage.openActionSheet().action2().displayLabel.label, "アクション 2 が押されました")
            }
            XCTContext.runActivity(named: "キャンセルボタンを押すとラベルがクリアされ、シートが閉じること") { _ in
                // シートが閉じていることを確認
                XCTAssertFalse(subPage.openActionSheet().cancel().sheetTitle.exists, "シートが閉じていません")
                // ラベルのクリアを確認(label自体が見つからなくなる)
                XCTAssertFalse(subPage.displayLabel.exists, "ラベルがクリアされていません")
            }
        }
    }

//    func Example() {
//        XCTContext.runActivity(named: "ボタンをtap、ActionSheetのCancelをtapし、Labelの文言を確認") { (activity) in
//            waitToHittable(for: app.buttons["SubViewController-button"]).tap()
//            waitToAppear(for: app.scrollViews.staticTexts["タイトルです"])
//            app.buttons["キャンセル"].tap()
//            XCTAssertFalse(app.staticTexts["SubViewController-label"].exists)
//        }
//    }
}


//extension XCTestCase {
//    func waitToAppear(for element: XCUIElement,
//                      timeout: TimeInterval = 15,
//                      file: StaticString = #file,
//                      line: UInt = #line) {
//        let predicate = NSPredicate(format: "exists == true")
//        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
//        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
//        XCTAssertEqual(result, .completed, file: file, line: line)
//    }
//
//    func waitToHittable(for element: XCUIElement,
//                        timeout: TimeInterval = 15,
//                        file: StaticString = #file,
//                        line: UInt = #line) -> XCUIElement {
//        let predicate = NSPredicate(format: "hittable == true")
//        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
//        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
//        XCTAssertEqual(result, .completed, file: file, line: line)
//        return element
//    }
//}
