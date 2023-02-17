# sample-xcuitest

[![Xcodebuild-UITest](https://github.com/mozkzki/sample-xcuitest/actions/workflows/xcodebuild-uitest.yml/badge.svg)](https://github.com/mozkzki/sample-xcuitest/actions/workflows/xcodebuild-uitest.yml)
[![Xcodebuild-UITest-Another-Report](https://github.com/mozkzki/sample-xcuitest/actions/workflows/xcodebuild-uitest-another-report.yml/badge.svg)](https://github.com/mozkzki/sample-xcuitest/actions/workflows/xcodebuild-uitest-another-report.yml)
[![Fastlane-UITest](https://github.com/mozkzki/sample-xcuitest/actions/workflows/fastlane-uitest.yml/badge.svg)](https://github.com/mozkzki/sample-xcuitest/actions/workflows/fastlane-uitest.yml)
[![Fastlane-UITest-Another-Report](https://github.com/mozkzki/sample-xcuitest/actions/workflows/fastlane-uitest-another-report.yml/badge.svg)](https://github.com/mozkzki/sample-xcuitest/actions/workflows/fastlane-uitest-another-report.yml)
[![Fastlane-UITest-Parallel](https://github.com/mozkzki/sample-xcuitest/actions/workflows/fastlane-uitest-parallel.yml/badge.svg)](https://github.com/mozkzki/sample-xcuitest/actions/workflows/fastlane-uitest-parallel.yml)

SwiftでのUI系自動テスト(XCUITest, XCUtest)のサンプルです。

## プロジェクト

|Target名|説明|利用ライブラリ|
|--|--|--|
|UITestSample|アプリのターゲット。UIKit利用。||
|UITestSampleTests|UnitTestのターゲット。<br>「スナップショットテスト (その1)」のコードを格納。|・[ios-snapshot-test-case](https://github.com/uber/ios-snapshot-test-case)<br>・XCTest（標準)|
|UITestSampleTests2|UnitTestのターゲット。<br>「スナップショットテスト (その2)」のコードを格納。|・[swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing)<br>・XCTest（標準)|
|UITestSampleUITest|UIテストのターゲット。`Page Object Pattern`を導入。|・XCTest(標準)<br>・XCUITest(標準)|

|Scheme名|Test Target|
|--|--|
|SnapShot|UITestSampleUITests|
|SnapShotTest|UITestSampleTests|
|SnapShotTest2|UITestSampleTests2|
|UITest|UITestSampleUITests|

## ローカル実行

### fastlane

`ruby`, `bundler`は導入済みの前提。

```bash
bundle install --path=.bundle
bundle exec fastlane ui_test
```

各laneの詳細。
|lane|起動するScheme|内容|呼出サンプル|
|--|--|--|--|
|ui_test|UITest|UIテスト実施|`./run/fastlane-uitest.sh`|
|make_report|-|UIテストのレポート生成||
|build_for_ui_test|UITest|UIテスト用のビルド(分散実行用)|`./run/fastlane-uitest-parallel.sh`|
|ui_test_without_building|UITest|UIテスト実施(分散実行用、テストクラス指定あり)|`./run/fastlane-uitest-parallel.sh`|
|snapshot|SnapShot|スナップショット取得(Fastlaneの標準action `snapshot`を使用)|`./run/fastlane-snapshot.sh`|
|capture_snapshot|SnapShotTest|スナップショットテスト(その1)用の正解画像を取得|`./run/fastlane-snapshot-test1-1-capture.sh`|
|snapshot_test|SnapShotTest|スナップショットテスト(その1)を実施|`./run/fastlane-snapshot-test1-2-testrun.sh`|
|snapshot_test2|SnapShotTest2|スナップショットテスト(その2)を実施(初回は正解画像を取得)|`./run/fastlane-snapshot-test2-testrun.sh`|

## CI

### GitHub Actions

下記5つのworkflowを定期実行中。

|workflow|yml|処理内容|レポート形式|定期実行?|手動実行可能?|
|--|--|--|--|--|--|
|Xcodebuild-UITest|xcodebuild-uitest.yml|UIテスト実施(xcodebuildで起動)|[XCTestHTMLReport](https://github.com/XCTestHTMLReport/XCTestHTMLReport)|○|○|
|Xcodebuild-UITest-Another-Report|xcodebuild-uitest-another-report.yml|UIテスト実施(xcodebuildで起動)|[xcresulttool](https://github.com/kishikawakatsumi/xcresulttool)|○|○|
|Fastlane-UITest|fastlane-uitest.yml|UIテスト実施(fastlaneで起動)|[XCTestHTMLReport](https://github.com/XCTestHTMLReport/XCTestHTMLReport)|○|○|
|Fastlane-UITest-Another-Report|fastlane-uitest-another-report.yml|UIテスト実施(fastlaneで起動)|[xcresulttool](https://github.com/kishikawakatsumi/xcresulttool)|○|○|
|Fastlane-UITest-Parallel|fastlane-uitest-parallel.yml|UIテスト並列実施(fastlaneで起動)|-|○|○|

## 詳細

<details>
<summary>詳細を見る</summary>

### スナップショット撮影

下記で`./snapshots`以下にスナップショットが保存される。
提出用画面の説明等にも使える。
fastlaneの標準actionである`snapshot`の機能で実現している。

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

#### テスト実施

下記で正解画像との比較が実施される。

```bash
bundle exec fastlane snapshot_test tests:UITestSampleTests/MainViewControllerTests/testMainViewSnapshot 
```

### スナップショットテスト (その2)

[swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing)を使った方法。

参考：[メルペイiOSチームのスナップショットテストを効率化した話 | メルカリエンジニアリング](https://engineering.mercari.com/blog/entry/20201220-ios-snapshot-testing/)

#### 正解画像取得、テスト実施

下記で`./__Snapshots__/*`に正解画像が保存される（初回実行時）。
その後同じコマンドで正解画像との比較が実施される。

```bash
bundle exec fastlane snapshot_test2 tests:UITestSampleTests2/MainViewControllerTests/testMainViewSnapshot 
```

### 並列実行

#### 前提

- ビルドとテスト実施を分ける
  - `build-for-testing`と`test-without-building`で分ける (xcodebuildのコマンド)
- テストメソッドは小分けにする
  - `XCTestCase`単位で分散される模様
  - 同じ`XCTestCase`に実装されたテストは分散されない
  - 下記のようにテスト実施クラスを小分けにする必要がある

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

- シミュレーター関連の動作
  - シミュレーターを起動しているとGUIで動作確認可能(並列指定の場合、cloneが複数台立ち上がる)
  - シミュレーターが1台も起動していない(アプリプロセス自体が無い)と、裏で動く

#### 並列実行パターンと結果まとめ

Mac(local)で下記パターンの並列実行を試した。

|パターン|結果(テストケースを分散)|結果(機種で分散)|
|--|--|--|
|Xcodeから|○|試してない|
|`xcodebuild`コマンド|×|試してない|
|`xcodebuild`コマンド (`xctestproducts`指定)|×|試してない|
|fastleneで並列実行|×|○|

#### 各パターン詳細

##### Xcode(GUI)で並列実行

シミュレーターが複数立ち上がり、各OS上でテストが並列実行される。

##### xcodebuildで並列実行

**結果**

- 並列にテスト実行されない（1シミュレータのみでテストが実行されてしまう）
- シミュレーター自体は徐々に指定数立ち上がるが、残りの3台でテスト実施がされない
- 下記と同じ状況？
  - [xcode - xcodebuild build-for-testing not evenly distributing tests across multiple ios simulators - Stack Overflow](https://stackoverflow.com/questions/72989993/xcodebuild-build-for-testing-not-evenly-distributing-tests-across-multiple-ios-s)

**試したコマンド**

```bash
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
  -xctestrun ./build/Build/Products/UITestSample_iphonesimulator16.2-arm64-x86_64.xctestrun
```

- 注意(メモ)
  - `-sdk iphonesimulator`を忘れるとtestで失敗する
  - buildが初回こけたので`-allowProvisioningUpdates`をつけて1度だけ実行した

##### xcodebuildで並列実行 (`xctestproducts`指定)

- 同様に、並列実行されない
- Xcodeの最新だと`xctestrun`ではなく`xctestproducts`を指定してテスト出来るので試したが
  - なお、最新(Xcode14.2)でも`xctestrun`で動きはする
  - 参考
    - [Xcode13.3のTesting周りについてまとめてみた｜tarappo｜note](https://note.com/tarappo/n/na3c50cbc2fab)

##### fastlaneで並列実行

**結論**

- fastlaneコマンド単体レベルでは、テストケースの分散・並列実行は出来ていない
  - GitHub Actionsで複数runnerを立ち上げて、テストケース指定で並列分散実行することは可能 (ただ遅い..)
- 複数機種で同じテストケースを並列実行することは可能

**fastlane `run_tests` (`scan`) の並列実行関係のパラメータ**

```txt
parallel_testing: true,
concurrent_workers: 4,
max_concurrent_simulators: 4,
disable_concurrent_testing: false,
```

**1機種指定**

例

```txt
devices: ["iPhone 14"]
```

- 1台のシミュレーターでテスト1〜4が実行される
- `concurrent_workers: 4`にしても**勝手にテストケースを分散実行してくれるわけではない** (下記動作になる)
  - シミュレーターは4台起動する
  - が、**動作しているのは1台でその1台でテストがシリアルに実行される**
  - 実行時間的に見て、裏で動く場合(シミュレータ起動無し)もシリアル動作と思われる
  - 事前にシミュレータを起動させても別のcloneが立ち上がり同様のシリアル動作となる

**複数機種指定**

例

```txt
devices: ["iPhone 14", "iPhone 14 Pro", "iPhone 14 Plus", "iPhone 14 Pro Max"]
```

- 各シミュレーター(4台)で同じテスト(テスト1〜4)が並列に実行される

### 部分実行

`-only-testing:`を使う。拡張子(`.swift`)まで指定すると動かなかった。

```bash
xcodebuild test-without-building \
    -scheme UITestSample \
    -destination 'OS=16.2,name=iPhone 14' \
    -only-testing:UITestSampleUITests/SampleUITests/testメインページのテスト
```

</details>

## 参考

- XCUITest
  - [XCUIApplication | Apple Developer Documentation](https://developer.apple.com/documentation/xctest/xcuiapplication)
  - [XCTestCase | Apple Developer Documentation](https://developer.apple.com/documentation/xctest/xctestcase)
  - [XcodeのUIテストフレームワーク「XCUITest」のTips](https://qiita.com/y-some/items/d0c32f6e60e8ea2367fa)
  - [XCUITestのつらさを乗り越えて、iOSアプリにUITestを導入する - Speaker Deck](https://speakerdeck.com/satotakeshi/xcuitestfalseturasawocheng-riyue-ete-iosahuriniuitestwodao-ru-suru?slide=33)
- xcodebuild
  - [XCTestCaseで作ったテストをxcodebuildで実行する方法 - Qiita](https://qiita.com/gremito/items/835f06511b80e4efafff)
  - [Xcodeでのビルドを自動化するxcodebuildコマンドとIPAファイルを作成してiTunes Connect(Testflight)に投げる方法 - 酢ろぐ！](https://blog.ch3cooh.jp/entry/20150210/1423573065)
- 並列実行
  - [Parallel testing: get feedback earlier, release faster | by Paweł Zemsta | AzimoLabs | Medium](https://medium.com/azimolabs/parallel-testing-get-feedback-earlier-release-faster-b66d4dd08930)
- [fastlane](https://docs.fastlane.tools/)
  - [Fastfile - fastlane docs](https://docs.fastlane.tools/advanced/Fastfile/)
  - [Available Actions - fastlane docs](https://docs.fastlane.tools/actions/)
  - [run_tests](https://docs.fastlane.tools/actions/run_tests/) パラメーター詳細
  - [scan](http://docs.fastlane.tools/actions/scan/#scan) パラメーター詳細
  - [fastlane でスクリーンショット撮影するまでのセットアップ - Daisuke TONOSAKI Weblog](https://daisuke-t-jp.hatenablog.com/entry/2020/09/07/fastlane-snapshot-setup)
  - [【iOS】複数端末のUIテストを自動化しよう – XCUITestとfastlaneとBeyond Compareで実装 | thilog](https://thilog.com/xcode-xcuitest-fastlane/)
- [GitHub Actions](https://docs.github.com/ja/actions)
  - [Workflow syntax for GitHub Actions - GitHub Docs](https://docs.github.com/ja/actions/using-workflows/workflow-syntax-for-github-actions)
  - [runner-images/images/macos/macos-12-Readme.md](https://github.com/actions/runner-images/blob/main/images/macos/macos-12-Readme.md)
  - [GitHub Marketplace · Actions to improve your workflow](https://github.com/marketplace?type=actions)
  - [GitHub Actions で Xcode プロジェクトをビルドしてみる](https://zenn.dev/koogawa/articles/54ff450a6dc5fd)
