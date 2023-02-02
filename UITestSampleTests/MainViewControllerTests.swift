//
//  SnapshotTest.swift
//  UITestSampleUITests
//
//  Created by mozkzki on 2023/01/26.
//  Copyright © 2023 mozksoft. All rights reserved.
//

import XCTest
import UIKit
@testable import UITestSample

class MainViewControllerTests: SnapshotTestCase {

    func testHoge() {

    }
    
    func testMainViewSnapshot() throws {
        print("◆◆◆◆◆◆◆◆◆◆ test")
        let dic = ProcessInfo.processInfo.environment
        if let value: String = dic["SNAPSHOT_TEST_RECORD_MODE"] {
            print(value)
        }
        print("◆◆◆◆◆◆◆◆◆◆ test")

        let vc = MainViewController()
        FBSnapshotVerifyView(vc.view)
    }
}
