# Vericook

Vericook は、Google カスタム検索 API を使用して、信頼できる企業サイトからレシピを検索するアプリケーションです。

## プロジェクトセットアップ

### 必要な依存関係をインストール

```bash
docker build -t vericook .
```

### 開発サーバーの起動

```bash
docker run --name vericook -it -p 80:80 -v .:/app vericook
```

### 本番用ビルド

```bash
npm run build
```

### コードのリントと修正
以下のコマンドでコードのリントを実行し、自動修正を行います。
```bash
npm run lint
```

## 環境変数の設定

アプリケーションで Google カスタム検索 API を使用するために、以下の環境変数を設定してください。

### `.env` ファイルの例
```
VUE_APP_GOOGLE_API_KEY=your-google-api-key
VUE_APP_GOOGLE_API_CX=your-google-api-cx
```

- **`VUE_APP_GOOGLE_API_KEY`**: Google Cloud Console で取得した API キー。
- **`VUE_APP_GOOGLE_API_CX`**: Google カスタム検索エンジンの識別子。

## デプロイ

### GitHub Pages にデプロイ
1. プロジェクトを本番用にビルドします。
   ```bash
   npm run build
   ```
2. ビルドされた `dist` ディレクトリを GitHub Pages にデプロイします。

GitHub Actions を使用して自動デプロイする場合は、リポジトリの Secrets に以下の環境変数を設定してください。
- `VUE_APP_GOOGLE_API_KEY`
- `VUE_APP_GOOGLE_API_CX`

**メモ**
 - [cxはここ](https://programmablesearchengine.google.com/controlpanel/all)
 - [apiKeyはここ](https://console.cloud.google.com/apis/dashboard)


## ライセンス
このプロジェクトは [MIT ライセンス](LICENSE) のもとで公開されています。

## 参考リンク
- [Vue CLI ドキュメント](https://cli.vuejs.org/config/)
- [Google カスタム検索 API](https://developers.google.com/custom-search/v1/overview)
