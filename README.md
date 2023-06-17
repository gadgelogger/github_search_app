# GitHub_search_app

GithubAPIを利用してGithubのリポジトリを検索する超シンプルなアプリです。ど素人なので可能な限り頑張って、要件を満たすように作りました。
> **:warning: 採点の前に**  
> - 中の人はFlutter歴１年でド素人です。インターンにも落ちまくっておりチーム開発の経験がありません。なのでGithubのリポジトリ運用がめちゃくちゃだったりコード規則ガン無視で最高に汚いです。お許しください。
> - できないならば出来ないなりに努力してChatGPTやネット等を使い調べて完成させました。拙い部分もありますが採点よろしくお願いします。

## とりまアプリの全体像

一覧(Light)|一覧(Dark)
--|--
![index-light](https://user-images.githubusercontent.com/39609331/246593499-2ae49fd5-6828-4d26-bf27-ed96247731e1.PNG)|![index-dark](https://user-images.githubusercontent.com/39609331/246593502-acb74ebd-a2d5-4947-bc67-24b8d7ab0ce3.PNG)

詳細|0件|エラー
--|--|--
![view](https://user-images.githubusercontent.com/39609331/246593594-a6320952-c1f6-43e9-8516-82b7d8a0b22d.PNG)|![empty](https://user-images.githubusercontent.com/39609331/246593598-0c3edda5-50db-4ef1-8ba8-c50d6a1f5889.PNG)|![error](https://user-images.githubusercontent.com/39609331/246593596-c1e630bf-6234-4d53-abf4-448bf06e688d.PNG)

![github_search_0_9_0_demo](https://user-images.githubusercontent.com/39609331/246594092-7e26ccd3-587b-41aa-8565-fd3182c8c274.gif)

## ビルド方法
mainブランチにdevからmergeしてあるので、cloneすれば動くはずです。。。！
#### ソースコードを clone
  
```bash
git clone https://github.com/gadgelogger/github_search_app.git
```
## 技術スタックやら
- アプリの機能
  - GitHub リポジトリの検索と詳細表示
  - 無限スクロール対応
- [fast_i18n](https://pub.dev/packages/fast_i18n) を使った多言語対応（日本語/英語）
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) を使ったアプリアイコン
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) を使ったスプラッシュ画面
- [responsive_framework](https://pub.dev/packages/responsive_framework) を使ったレスポンシブ対応
- [GitHub Actions](https://github.co.jp/features/actions) によるCI(自動テストと自動ビルド)
- ダークモード対応
- サポートするプラットフォーム
  - iOS / Android 

### 今後対応予定

- 検索結果の並び替えやデータの永続化
- いちいち検索するのダルいので、検索履歴の保存とサジェスト的な機能を作りたい（言い訳：時間が足りなかった）
### 対応しないこと

- Firebase 連携とか

##フォルダ構成
```  
// github_search_app/ - プロジェクトのルートディレクトリ
// ├── android/ - ネイティブのAndroidコードを格納するためのディレクトリ
// ├── ios/ - ネイティブのiOSコードを格納するためのディレクトリ
// ├── lib/ - Dartのソースコードを格納するためのディレクトリ
// │   ├── main.dart - アプリケーションのエントリーポイント
// │   ├── screens/ - アプリケーションの各画面を格納するディレクトリ
// │   │   ├── search_screen.dart - 検索画面のコードを格納するファイル
// │   ├── providers/ - 状態管理に関するコードを格納するディレクトリ
// │   │   ├── search_provider.dart - 検索機能に関する状態管理のコードを格納するファイル
// │   ├── models/ - データモデルを格納するディレクトリ
// │   │   ├── repository.dart - リポジトリのデータモデルを格納するファイル
// ├── test/ - テストコードを格納するディレクトリ
// │   ├── widget_test.dart - ウィジェットのテストコードを格納するファイル
// ├── pubspec.yaml - アプリケーションの依存関係とメタデータを記述するファイル
// └── README.md - プロジェクトに関する説明とドキュメンテーションを含むファイル
              どの層からもアクセス可能な便利クラス（ロガー、拡張メソッドなど）
```
とりあえず素人ながらわかりやすいようにファイルを分割しています。（API関連はAPI関連/Screen関連はScreenへ）

##CIとか
- よくわからないので[GitHub Actions](https://github.co.jp/features/actions) を利用して CI を構築しています。
  - 設定ではプルリクエストが作成や更新された時、もしくは `main` または `dev` ブランチに `push` されたときに CI が作動します。


