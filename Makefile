NAME = cub3d

CC = gcc
CFLAGS = -Wall -Wextra -Werror -g -fdiagnostics-color=always
COMPILE = $(CC) $(CFLAGS)
LIBFT = ./libft
LIB = $(LIBFT)/libft.a

INCLUDES =	-I$(LIBFT)\
			-Iminilibx\
			-Iincludes



LIBDIRS =	-Lminilibx\
			-L$(LIBFT)

LIBS =	-lft\
		-lmlx

FRAMEWORKS =	-framework OpenGL\
				-framework AppKit

SDIR = ./src

SRCS =	main.c\
		controls.c\
		movement.c\
		utils.c\
		check_map.c\
		parse_utils.c\
		parse_utils1.c\
		parse.c\
		read_textures.c\
		cast_ray.c\
		make_rayspos_test.c\
		drawpos_test.c\
		rgb_to_hex.c

ODIR = ./obj
OBJS = $(patsubst %,$(ODIR)/%,$(SRCS:.c=.o))

$(ODIR)/%.o : $(SDIR)/*/%.c
	@mkdir -p obj
	@echo "Creating object : $@"
	@$(COMPILE) $(INCLUDES) -c -o $@ $<

all: libft | $(NAME)

$(NAME): $(LIB) $(OBJS)
	@echo "Creating executable $(NAME)"
	@$(COMPILE) $(OBJS) $(LIBDIRS) $(LIBS) $(FRAMEWORKS) -o $(NAME)

run: $(NAME)
	@./$<
	@echo "Worked just fine"

clean:
	@echo "Removing object files $(NAME)"
	@rm -rf $(OBJS) $(ODIR)
	@$(MAKE) clean -C $(LIBFT)

fclean: clean
	@echo "Removing executable file $(NAME)"
	@rm -f $(NAME)
	@$(MAKE) fclean -C $(LIBFT)

libft:
	@$(MAKE) -C $(LIBFT)

re: fclean | all

.PHONY: all clean fclean libft run re
