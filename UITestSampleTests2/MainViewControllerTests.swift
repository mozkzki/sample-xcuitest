//
//  MainViewControllerTests.swift
//  UITestSampleTests2
//
//  Created by katoyutaka on 2023/02/03.
//  Copyright © 2023 mozksoft. All rights reserved.
//

import SnapshotTesting
import XCTest
import UIKit
@testable import UITestSample

class MainViewControllerTests: XCTestCase {

    func testMainViewSnapshot() throws {
        let vc = MainViewController()
        assertSnapshot(matching: vc, as: .image)
    }
}
