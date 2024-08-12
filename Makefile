VOLUME_WP=		/home/dongyeuk/data/wordpress
VOLUME_DB=		/home/dongyeuk/data/mariadb
COMPOSE_DIR=	./srcs/docker-compose.yml

.PHONY:	all clean fclean re

all:
	mkdir -p $(VOLUME_WP)
	mkdir -p $(VOLUME_DB)
	docker compose -f $(COMPOSE_DIR) up -d --build

down:
	docker compose -f $(COMPOSE_DIR) down

logs:
	docker compose -f $(COMPOSE_DIR) logs

restart: clean all

clean:
	docker compose -f $(COMPOSE_DIR) down -v

fclean:	clean
	docker system prune -a
	rm -rf $(VOLUME_WP)/*
	rm -rf $(VOLUME_DB)/*

re:	fclean all
