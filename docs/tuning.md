# チューニング

_一改善につき一ベンチ_

原則としてボトルネックを見つけてから以下を行う

## 構成決める

VM の役割を決める大体下記のようになる

- web server, app 兼任が 1 台
- app 専用が 1 台
- db 専用が 1 台

構成が決まったら不要な service は stop & disable にしておく。

db は全てのインスタンスからのアクセスを許可しておく。

```sql
# 外部アクセスを許可
> grant all privileges on isuumo.\* to isucon@'%' identified by 'isucon' with grant option;

# 確認
> select user, host from mysql.user;
```

## innodb のチューニング

```conf
innodb_buffer_pool_size=1500M
innodb_flush_method=O_DIRECT
innodb_flush_log_at_trx_commit = 2
```

## MySQL の Index

必ず percona toolkit の分析の結果から explain して調査する
application によっては初期化処理が走って alter table の結果が初期化されてしまう。  
初期化スクリプトに query を追加すれば解決する。

```sh
EXPLAIN <query>

# 作成
ALTER TABLE <table_name> ADD INDEX <index_name> (col1, col2, ...);

# 確認
SHOW INDEX FROM <table_name>;

# 削除
ALTER TABLE <table_name> DROP INDEX <index_name>;
```

## select all をやめる

`select * from` している部分で使う column が決まっている場合は指定する

## bulk insert

for loop による insert は bulk insert で最適化する。

```sql
# Before
INSERT INTO table_name (col_1, col_2, col_3) VALUES (1, 2, 3);

# After
INSERT INTO table_name (col_1, col_2, col_3) VALUES (1, 2, 3), (4, 5, 6), (7, 8, 9);
```

## cache

session とか redis に載せると早くなるかも
