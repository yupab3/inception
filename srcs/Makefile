VOLUME_WP=	~/바탕화면/bk/wordpress
VOLUME_DB=	~/바탕화면/bk/mariadb

.PHONY:	all clean fclean re

all:
	docker compose up -d

restart: clean all

clean:
	docker compose down -v

fclean:	clean
	docker system prune -a
	rm -rf $(VOLUME_WP)/*
	rm -rf $(VOLUME_DB)/*

re:	fclean all
