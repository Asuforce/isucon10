all: isuumo

isuumo: *.go
	CGO_ENABLED="0" GOOS="linux" GOARCH="amd64" go build -o isuumo

sql:
	scp -rpC ../db/3_AlterTableData.sql isucon1:/home/isucon/isuumo/webapp/mysql/db
	scp -rpC ../db/3_AlterTableData.sql isucon2:/home/isucon/isuumo/webapp/mysql/db

deploy: isuumo sql
	ssh -A isucon1 rm /home/isucon/isuumo/webapp/go/isuumo
	ssh -A isucon2 rm /home/isucon/isuumo/webapp/go/isuumo
	scp -rpC ./isuumo isucon1:/home/isucon/isuumo/webapp/go
	scp -rpC ./isuumo isucon2:/home/isucon/isuumo/webapp/go
	ssh -A isucon1 sudo systemctl restart isuumo.go
	ssh -A isucon2 sudo systemctl restart isuumo.go
