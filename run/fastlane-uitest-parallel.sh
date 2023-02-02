#!/bin/bash

# ローカルでの実行は失敗する事が多い
# CIで下記のテストジョブをRunner(別VM)に分散させる必要がある

bundle exec fastlane build_for_ui_test

bundle exec fastlane ui_test_without_building tests:"UITestSampleUITests/SampleUITest1/testメインページのテスト1"
# bundle exec fastlane ui_test_without_building tests:"UITestSampleUITests/SampleUITest2/testサブページのテスト1" &
# bundle exec fastlane ui_test_without_building tests:"UITestSampleUITests/SampleUITest1/testメインページのテスト1" &
# bundle exec fastlane ui_test_without_building tests:"UITestSampleUITests/SampleUITest2/testサブページのテスト1" &
