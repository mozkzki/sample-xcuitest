//
//  SampleUITests.swift
//  UITestSample
//
//  Created by mozkzki on 2023/01/13.
//  Copyright © 2023 mozksoft. All rights reserved.
//

import XCTest

class SampleUITest1: SampleUITestBase {
    func testメインページのテスト1() {
        checkMainPage()
        snapshot("launch")
    }
}

class SampleUITest2: SampleUITestBase {
    func testサブページのテスト1() {
        checkSubPage()
    }
}

class SampleUITest3: SampleUITestBase {
    func testメインページのテスト2() {
        checkMainPage()
    }
}

class SampleUITest4: SampleUITestBase {
    func testサブページのテスト2() {
        checkSubPage()
    }
}
