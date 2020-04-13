.PHONY: avoid-home build install-alias run shell ~/.gimp-latest-config

run: ~/.gimp-latest-config avoid-home
	docker run -it --rm -e DISPLAY \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v ~/.gimp-latest-config:/home/sam/.config/GIMP \
		-v "$(PWD):$(PWD)" \
		-w "$(PWD)" gimp-latest gimp

build:
	docker build --pull -t gimp-latest .

shell: ~/.gimp-latest-config avoid-home
	docker run -it --rm -e DISPLAY \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v ~/.gimp-latest-config:/home/sam/.config/GIMP \
		-v "$(PWD):$(PWD)" \
		-w "$(PWD)" gimp-latest

install-alias:
	echo "alias gimp-latest=\"make -f '$(PWD)'/Makefile run\"" >> ~/.bashrc

~/.gimp-latest-config:
	[ -d ~/.gimp-latest-config ] || mkdir ~/.gimp-latest-config

clean:
	[ ! -d ~/.gimp-latest-config ] || rm -r ~/.gimp-latest-config
	docker rmi gimp-latest

avoid-home:
	@[ ! "$(PWD)" = "$(HOME)" ] || ( echo 'ERROR:  Do not run from $(HOME)' >&2; false  )
