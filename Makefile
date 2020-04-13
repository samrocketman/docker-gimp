CMD := gimp
.PHONY: avoid-home build clean clean-all clean-config install-alias run shell ~/.gimp-latest-config

# default target is run
run: ~/.gimp-latest-config avoid-home
	docker run -it --rm -e DISPLAY \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v ~/.gimp-latest-config:/home/sam/.config/GIMP \
		-v "$(PWD):$(PWD)" \
		-w "$(PWD)" gimp-latest $(CMD)

avoid-home:
	@[ ! "$(PWD)" = "$(HOME)" ] || ( echo 'ERROR:  Do not run from $(HOME)' >&2; false  )

build:
	docker build --pull -t gimp-latest .

clean:
	docker rmi gimp-latest

clean-all: clean clean-config

clean-config:
	[ ! -d ~/.gimp-latest-config ] || rm -r ~/.gimp-latest-config

install-alias:
	echo "alias gimp-latest=\"make -f '$(PWD)'/Makefile run\"" >> ~/.bashrc

# Call run but unset CMD variable so container runs default shell.
shell: CMD =
shell: run

~/.gimp-latest-config:
	[ -d ~/.gimp-latest-config ] || mkdir ~/.gimp-latest-config
