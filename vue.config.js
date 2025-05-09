const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  devServer: {
    watchFiles: ['src/**/*', 'public/**/*'], // ファイル変更を監視
    host: '0.0.0.0', // 外部アクセスを許可
    port: 80, // ポート番号
  },
  publicPath: '/VeriCook/' // リポジトリ名を指定
})
