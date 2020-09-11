# チューニング

原則としてボトルネックを見つけてから以下を行う

## MySQL の Index

```sh
# 作成
ALTER TABLE <table_name> ADD INDEX <index_name> (col1, col2, ...);

# 確認
SHOW INDEX FROM <table_name>;

# 削除
ALTER TABLE <table_name> DROP INDEX <index_name>;
```
