# First step

_推測するな計測せよ_

予選を突破するための初動を固める

## レギュレーションの熟読

以下を熟読
特に**スコアの計算方法**、**Success/Fail の判定条件**、**許可されること・されないこと**に気をつける

- 事前告知される内容
- 当日公開される内容

## ssh ログイン

1. ssh_config の host を設定する
1. 各々の PC に設定を追加する
1. `/home/isucon/.ssh/authorized_key` に各自の公開鍵を追加

## システムを把握する

いきなりチューニングをしない、確認が大事

### ブラウザでアクセス

- アプリケーションを把握
  - ログインできない場合はハックして改変
- 簡易 ER 図の作成
  - リレーション、CRUD 状態をホワイトボードに書き出す

### サーバ上で以下を実行

#### マシンスペックのチェック

- `$ lscpu`
  - cpu の使用状況
  - `$ /proc/cpuinfo` で詳細
- `$ /proc/meminfo`
  - メモリの使用状況を確認

#### プロセスのチェック

何のデーモンやミドルウェアで構成されているかを把握

- `$ pstree`
  - プロセスの確認（簡易
- `$ ps auxwwf`
  - プロセスの確認（詳細
- `$ lsof`
  - ファイルを実行しているプロセスを知りたい場合
- `$ env`
  - 環境変数を確認しておく
  - 本番環境で実行されているか

#### サービス名の確認

## Git で管理

1. ソースをローカルに持ってくる

   ```sh
   # Get App
   $ scp -rpC isucon:/home/isucon/webapp/go webapp/
   $ scp -rpC isucon:/home/isucon/webapp/static webapp/
   ```

### mysqldump

`/home/isucon` で実行する

```sh
# 指定データベースのテーブルとデータを取得
$ mysqldump -uroot -h localhost #{database name} -n > dump.sql

# ローカルにコピー
$ scp -rpC isucon:/home/isucon/dump.sql initdb.d/
```

落としたらコードと一緒に眺めるとよい

## 初回のベンチを実行する

初回のベンチを実行し、スコアを取得する。このスコアを基準に改善していく。

## 必要なツールのインストール

調査に必須のツールをまとめてインストールする

### local

alp, percona-toolkit を使う

```sh
$ brew install alp percona-toolkit
```

### VM

- netdata
  - `$ bash <(curl -Ss https://my-netdata.io/kickstart.sh)`
  - netdata の画面は常に表示しておくと良い
  - port: 19999
- htop もあるといいかも

## Go に切り替えてベンチマーク

### 準備

- systemctl 使って Go に切り替え
- `$ journalctl -f` してからベンチを実行する
  - 問題が起きないか確認する

## ボトルネックを見つける

`make get` で nginx, slow-query のログを取得できる。それぞれ設定を済ませておく。  
基本的に index 貼るのが最初の仕事。

### alp

nginx のログからどのエンドポイントがボトルネックかを測定する
ltsv format の設定と access log で ltsv を使うように変更

1. nginx のログの設定を行う
1. `make alp`

### Percona Toolkit

slow query の解析を行う

mysql conf はここらへんにある

- /etc/my.cnf
- /etc/mysql/my.cnf
- /etc/mysql/mysql.conf.d/mysqld.cnf`

sloq query の書き出しは以下

```conf:/etc/mysql/mysql.conf.d/mysqld.cnf
slow_query_log = 1
slow_query_log_file = /var/log/mysql/mysql-slow.log
long_query_time = 1
```

ツールの実行は 3 分くらいかかる

1. `make get`
1. 結果を gist に貼って共有する
