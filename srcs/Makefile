VOLUME_WP=	/Users/dongyeuk/Desktop/inceptionVolumes/wordpress
VOLUME_DB=	/Users/dongyeuk/Desktop/inceptionVolumes/mariadb

.PHONY:	all clean fclean re

all:
	docker-compose up

restart: clean all

clean:
	docker-compose down -v

fclean:	clean
	docker system prune -a
	rm -rf $(VOLUME_WP)/*
	rm -rf $(VOLUME_DB)/*

re:	fclean all