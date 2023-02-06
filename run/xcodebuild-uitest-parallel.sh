#!/bin/bash

# clean
rm -rf ./build

# build
xcodebuild clean build-for-testing \
        -project UITestSample.xcodeproj \
        -scheme UITest \
        -sdk iphonesimulator \
        -derivedDataPath ./build


# ui test
xcodebuild test-without-building \
        -destination 'OS=16.2,name=iPhone 14' \
        -parallel-testing-enabled YES \
        -parallel-testing-worker-count 4 \
        -maximum-concurrent-test-simulator-destinations 4 \
        -maximum-parallel-testing-workers 4 \
        -xctestrun ./build/Build/Products/UITest_iphonesimulator16.2-arm64-x86_64.xctestrun
