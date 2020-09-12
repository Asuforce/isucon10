alp:
	cat log/access.log | alp ltsv --sort=sum

sq:
	pt-query-digest --limit 10 log/mysql-slow.log

get: get_n get_sq

get_n:
	scp -rpC isucon1:/var/log/nginx/isuumo_access_log.tsv log/access.log
	ssh -A isucon1 sudo rm /var/log/nginx/isuumo_access_log.tsv
	ssh -A isucon1 sudo systemctl restart nginx

get_sq:
	ssh -A isucon3 sudo cp /var/log/mysql/mysql-slow.log /home/isucon/mysql-slow.log
	ssh -A isucon3 sudo chown isucon:isucon /home/isucon/mysql-slow.log
	scp -rpC isucon3:/home/isucon/mysql-slow.log log
	ssh -A isucon3 sudo rm /var/log/mysql/mysql-slow.log
	ssh -A isucon3 sudo systemctl restart mysql
