VOLUME_WP=		/Users/dongyeuk/inception/data/wordpress
VOLUME_DB=		/Users/dongyeuk/inception/data/mariadb
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
	docker compose -f $(COMPOSE_DIR) down -v --rmi all

fclean:	clean
	rm -rf $(VOLUME_WP)
	rm -rf $(VOLUME_DB)

re:	fclean all
