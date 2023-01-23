#!/bin/bash

# build
xcodebuild clean build-for-testing \
        -project UITestSample.xcodeproj \
        -scheme UITestSample \
        -sdk iphonesimulator \
        -testProductsPath ./build-new

# ui test
xcodebuild test-without-building \
        -destination 'OS=16.2,name=iPhone 14' \
        -parallel-testing-enabled YES \
        -parallel-testing-worker-count 4 \
        -maximum-concurrent-test-simulator-destinations 4 \
        -maximum-parallel-testing-workers 4 \
        -testProductsPath ./build-new.xctestproducts
