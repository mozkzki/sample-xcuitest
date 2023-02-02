# sample-xcuitest

[![CI](https://github.com/mozkzki/sample-xcuitest/actions/workflows/main.yml/badge.svg)](https://github.com/mozkzki/sample-xcuitest/actions/workflows/main.yml)

swiftでのUI自動テスト(XCUITest)のサンプルです。

- 下記を参考にしました
  - [XcodeのUIテストフレームワーク「XCUITest」のTips](https://qiita.com/y-some/items/d0c32f6e60e8ea2367fa)
- 下記の`Page Object Pattern`も導入
  - [XCUITestのつらさを乗り越えて、iOSアプリにUITestを導入する - Speaker Deck](https://speakerdeck.com/satotakeshi/xcuitestfalseturasawocheng-riyue-ete-iosahuriniuitestwodao-ru-suru?slide=33)
- Push時にGitHub Actionsでビルド&テスト実行

## 実行

`ruby`, `bundler`は導入済みの前提。

### テスト

```bash
bundle install --path=.bundle
bundle exec fastlane
# or
bundle exec fastlane ui_test
```

### スナップショット撮影

提出用画面の説明等にも使える。`./snapshots`以下に保存される。
これは、fastlaneのsnapshotプラグイン(?)の機能で実現している。
`fastlane/Fastfile`に定義を書いている。

```bash
bundle exec fastlane snapshot run --scheme "SnapShot" --configuration "Release"  --sdk "iphonesimulator"
```

### スナップショットテスト (その1)

[ios-snapshot-test-case](https://github.com/uber/ios-snapshot-test-case)を使った方法。

#### 正解画像取得

下記で`./snapshot_tests/ReferenceImages_64`に正解画像が保存される。

```bash
bundle exec fastlane capture_snapshot tests:UITestSampleTests/MainViewControllerTests/testMainViewSnapshot
```

#### テスト

下記で正解画像との比較が実施される。

```bash
bundle exec fastlane snapshot_test tests:UITestSampleTests/MainViewControllerTests/testMainViewSnapshot 
```

SwiftUIのPreview実装もそのままテストできるはず・・
- [SwiftUIのPreview実装をそのまま使って、Screenshot撮影を自動化する - Qiita](https://qiita.com/chocoyama/items/9ec8bda869521fbf27b7)

### スナップショットテスト (その2)

次は↓を試す。

- [/swift-snapshot-testing: 📸 Delightful Swift snapshot testing.](https://github.com/pointfreeco/swift-snapshot-testing)

## 並列実行

- 参考
  - [Parallel testing: get feedback earlier, release faster | by Paweł Zemsta | AzimoLabs | Medium](https://medium.com/azimolabs/parallel-testing-get-feedback-earlier-release-faster-b66d4dd08930)
- シミュレーター(mac,local,`xcodebuild`)での並列実行を試した
  - `build-for-testing`と`test-without-building`で分けるのがお作法っぽい
  - 上記サイトの通り、テスト実施クラスを小分けにする必要がある

  ```swift
  class AzimoUITestsLogin : XCTestCase {
    func test_login() {code}
  }
  class AzimoUITestsCreateRecipient : XCTestCase {
    func test_createRecipient()
  }
  class AzimoUITestsCreateTransfer : XCTestCase {
    func test_createTransfer() {code}
  }
  ```

  - XcodeのGUIはOK，コマンドライン(`xcodebuild`)はNG
    - XcodeのGUIから実行
      - シミュレーターが複数立ち上がり、各OS上でテストが並列実行される
    - `xcodebuild`
      - シミュレーターは徐々に指定数立ち上がる
      - が、テストが並列実行されない（1シミュレータのみで動作）
      - 下記と同じ状況？
        - [xcode - xcodebuild build-for-testing not evenly distributing tests across multiple ios simulators - Stack Overflow](https://stackoverflow.com/questions/72989993/xcodebuild-build-for-testing-not-evenly-distributing-tests-across-multiple-ios-s)
      - 試したコマンドは下記
        - `-sdk iphonesimulator`を忘れるとtestで失敗する
        - buildが初回こけたので`-allowProvisioningUpdates`をつけて1度だけ実行した

      ```bash
      # build
      xcodebuild clean build-for-testing \
        -project UITestSample.xcodeproj \
        -scheme UITestSample \
        -sdk iphonesimulator \
        -derivedDataPath ./build

      # ui test
      xcodebuild test-without-building \
        -destination 'OS=16.2,name=iPhone 14' \
        -parallel-testing-enabled YES \
        -parallel-testing-worker-count 4 \
        -maximum-concurrent-test-simulator-destinations 4 \
        -maximum-parallel-testing-workers 4 \
        -xctestrun ./build/Build/Products/UITestSample_iphonesimulator16.2-arm64-x86_64.xctestrun
      ```

    - Xcodeの最新だと`xctestrun`ではなく`xctestproducts`を指定してテスト出来る
      - 最新(Xcode14.2)でも`xctestrun`で動きはする
      - `xctestproducts`で動かしても並列実行されない
      - 参考
        - [Xcode13.3のTesting周りについてまとめてみた｜tarappo｜note](https://note.com/tarappo/n/na3c50cbc2fab)

### fastlaneでの並列実行

```bash
bandle exec fastlane ui_test
```

- そもそもの動作
  - シミュレーターを起動しているとGUIで動きが見れる(並列の場合、勝手にcloneが立ち上がる)
  - シミュレーターが1台も起動していない(アプリのプロセスが無い)と、裏で動く

- 並列動作
  - `devices: ["iPhone 14", "iPhone 14 Pro", "iPhone 14 Plus", "iPhone 14 Pro Max"]`のように複数機種を指定
    - →想定通り各シミュレーターで並列に動く(テストは1〜4までシリアルに)
  - `devices: ["iPhone 14"]`のように1機種を指定
    - →テスト1〜4が分散される動きにはならない
      - シミュレーターが4台起動するが動作しているのは1台でシリアルにテスト実行される
      - 実行時間的に見て、裏で動く場合(シミュレータ起動無し)もシリアル動作と思われる
      - 事前に機種を合わせたシミュレータを起動させておいても別のが立ち上がって↑と同じ動作になる（シリアル）

- `run_tests`(`scan`)のパラメータ詳細等は下記公式ページ参照
  - [run_tests - fastlane docs](https://docs.fastlane.tools/actions/run_tests/)
  - [scan - fastlane docs](http://docs.fastlane.tools/actions/scan/#scan)

- まとめ
  - テストの分散実行は出来てない
  - `xcodebuild`と同じ状況（根本はXcode側の動作か）

## 部分実行

`-only-testing:`を使う。`.swift`と拡張子まで指定すると動かなかった。

```bash
xcodebuild test-without-building \
    -scheme UITestSample \
    -destination 'OS=16.2,name=iPhone 14' \
    -only-testing:UITestSampleUITests/SampleUITests/testメインページのテスト
```

## 参考

- [runner-images/images/macos/macos-12-Readme.md](https://github.com/actions/runner-images/blob/main/images/macos/macos-12-Readme.md)
- [GitHub Actions で Xcode プロジェクトをビルドしてみる](https://zenn.dev/koogawa/articles/54ff450a6dc5fd)
- [XCTestCaseで作ったテストをxcodebuildで実行する方法 - Qiita](https://qiita.com/gremito/items/835f06511b80e4efafff)
- [Xcodeでのビルドを自動化するxcodebuildコマンドとIPAファイルを作成してiTunes Connect(Testflight)に投げる方法 - 酢ろぐ！](https://blog.ch3cooh.jp/entry/20150210/1423573065)
- [【iOS】複数端末のUIテストを自動化しよう – XCUITestとfastlaneとBeyond Compareで実装 | thilog](https://thilog.com/xcode-xcuitest-fastlane/)
