#!/bin/bash

rm -rf uitest_output/UITestSample.xcresult
xcodebuild -project UITestSample.xcodeproj -sdk iphonesimulator -scheme UITest -destination OS=16.2,name="iPhone 14" -configuration Debug test -resultBundlePath uitest_output/UITestSample.xcresult
