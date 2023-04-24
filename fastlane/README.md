fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios sample_lane

```sh
[bundle exec] fastlane ios sample_lane
```

Sample

### ios temp

```sh
[bundle exec] fastlane ios temp
```

fastlane自体のテスト用lane

### ios ui_test

```sh
[bundle exec] fastlane ios ui_test
```

UIテスト

### ios make_report

```sh
[bundle exec] fastlane ios make_report
```

UIテストのレポート生成

### ios build_for_ui_test

```sh
[bundle exec] fastlane ios build_for_ui_test
```

UIテスト用のビルド(分散実行用)

### ios ui_test_without_building

```sh
[bundle exec] fastlane ios ui_test_without_building
```

UIテスト(分散実行用、テストクラス指定あり)

### ios capture_snapshot

```sh
[bundle exec] fastlane ios capture_snapshot
```

スナップショットテスト(その1)用の正解画像を取得

### ios snapshot_test

```sh
[bundle exec] fastlane ios snapshot_test
```

スナップショットテスト(その1)を実施

### ios snapshot_test2

```sh
[bundle exec] fastlane ios snapshot_test2
```

スナップショットテスト(その2)を実施

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
