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
