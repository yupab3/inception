VOLUME_WP=	/home/dongyeuk/data/wordpress
VOLUME_DB=	/home/dongyeuk/data/mariadb

.PHONY:	all clean fclean re

all:
	mkdir -p $(VOLUME_WP)
	mkdir -p $(VOLUME_DB)
	docker compose up -d --build

down:
	docker compose down

restart: clean all

clean:
	docker compose down -v

fclean:	clean
	docker system prune -a
	rm -rf $(VOLUME_WP)/*
	rm -rf $(VOLUME_DB)/*

re:	fclean all
