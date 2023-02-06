//
//  SnapshotTestCase.swift
//  UITestSampleUITests
//
//  Created by mozkzki on 2023/01/26.
//  Copyright © 2023 mozksoft. All rights reserved.
//

//import FBSnapshotTestCase
import iOSSnapshotTestCase

class SnapshotTestCase: FBSnapshotTestCase {
    var window: UIWindow!

    override func setUp() {
        super.setUp()
//        recordMode = true
//        recordMode = false
        recordMode = ProcessInfo().environment["SNAPSHOT_TEST_RECORD_MODE"] == "true"
        fileNameOptions = [.device, .OS, .screenSize, .screenScale]
        window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
    }
}
