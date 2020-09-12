get_n:
	scp -rpC isucon1:/var/log/nginx/isuumo_access_log.tsv log/access.log
	ssh -A isucon1 sudo rm /var/log/nginx/isuumo_access_log.tsv
	ssh -A isucon1 sudo systemctl restart nginx

alp:
	cat log/access.log | alp ltsv --sort=sum

get_sq:
	ssh -A isucon3 sudo cp /var/log/mysql/mysql-slow.log /home/isucon/mysql-slow.log
	ssh -A isucon3 sudo chown isucon:isucon /home/isucon/mysql-slow.log
	scp -rpC isucon3:/home/isucon/mysql-slow.log log
	ssh -A isucon3 sudo rm /var/log/mysql/mysql-slow.log
	ssh -A isucon3 sudo systemctl restart mysql

sq:
	pt-query-digest --limit 10 log/mysql-slow.log

deploy:
	./scripts/deploy.sh
	@make restart

restart:
	@make restart_db
	@make restart_app
	@make restart_rev

restart_db:
	ssh -A db /home/isucon/deploy/scripts/restart.sh

restart_app:
	ssh -A app /home/isucon/deploy/scripts/restart_app.sh

restart_rev:
	ssh -A rev /home/isucon/deploy/scripts/restart_app.sh
