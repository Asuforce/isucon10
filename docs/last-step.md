# Last steps

終了間際に行う処理

調査、検証用のものを停止していく

## 戻す設定

- `my.cnf` の slow query 設定
- nginx の log を止める

## 止めるサービス

stop, disable を忘れずに

- `$ sudo systemctl stop netdata && sudo systemctl disable netdata`

## 1時間前に再起動

必要なデーモンを予め以下で再起動するようにしておく

- `$ sudo systemctl enable <unit-name>`
