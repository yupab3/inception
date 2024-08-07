VOLUME_WP=	~/Desktop/bk/wordpress
VOLUME_DB=	~/Desktop/bk/mariadb

.PHONY:	all clean fclean re

all:
	docker compose up

restart: clean all

clean:
	docker compose down -v

fclean:	clean
	docker system prune -a
	rm -rf $(VOLUME_WP)/*
	rm -rf $(VOLUME_DB)/*

re:	fclean all
