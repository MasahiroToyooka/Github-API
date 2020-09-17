# Github-API
### アプリ内容
GitHub APIを使用し情報をtableViewに表示する 
### デモ
<img src="https://user-images.githubusercontent.com/38667604/93537390-52e69b00-f986-11ea-9325-3570438d3cb4.gif" width="200">

### Setup
```pod install```

### ライブラリ選定理由
- Nuke - 画像キャッシュライブラリを比較している記事を読み、あんまり差があるわけではなさそうでしたので、使い慣れている方を選びました。
- DZNEmptyDataSet - 使い慣れているので選びました。
- R.swift - [比較記事を読み](https://qiita.com/doi_daihei/items/167a019dc165f48d7d66)、あんまり差があるわけではなさそうでしたので、導入が楽そうな方を選びました。

### 工夫した点
- webViewをロードする時にprogress barを表示する （Webサイト側で独自のプログレスバーを表示していると２つ表示されてしまう。）
- Combineでインクリメンタルサーチができるようにした

### 注意点
- simulatorでwebview内のメール、電話番号リンクをクリックした場合は何もおきません。
- [検索しすぎるとレートリミットになります](https://developer.github.com/v3/#rate-limiting)
