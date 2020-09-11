# 開発環境

これは雛形とし、本番ソースコードに合わせて調整していきましょう

## 前提

* Docker, Ruby は全員のPCにインストール済みとする

## Docker開発環境

### 準備

* `webapp/ruby` ディレクトリに Ruby ソースコードを配置してください
* `webapp/static` ディレクトリに静的ファイルを配置してください
* `initdb.d/` ディレクトリに SQL ファイルを配置してください。コンテナ起動時に自動的に指定データベースにインポートされます。
* `docker-compose-yml` ファイルの以下をソースコードに合わせて修正してください

```sh
      MYSQL_DATABASE: isucon
      MYSQL_USER: isucon
      MYSQL_PASSWORD: password
```

### 構築

```sh
# コンテナをバックグラウンドで起動
$ docker-compose up -d

# ログを表示
$ docker-compose logs -f

# キャッシュを使わずにビルドする。Dockerfileを変更した場合は --no-cache を付けるとミスがないです。
$ docker-compose build --no-cache
```

## ビルトインサーバー

* Docker開発環境が使えなかった場合は、ビルトインサーバーを使いましょう
