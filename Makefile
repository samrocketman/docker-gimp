.PHONY: build install-alias run shell ~/.gimp-latest-config

run: ~/.gimp-latest-config
	docker run --rm -e DISPLAY -e PWD -e CWD \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v "$(PWD):$(PWD)" \
		-v ~/.gimp-latest-config:/home/sam/.config/GIMP \
		-w "$(PWD)" gimp-latest gimp

build:
	docker build  -t gimp-latest .

shell: ~/.gimp-latest-config
	docker run -it --rm -e DISPLAY -e PWD -e CWD \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v "$(PWD):$(PWD)" \
		-v ~/.gimp-latest-config:/home/sam/.config/GIMP \
		-w "$(PWD)" gimp-latest

install-alias:
	echo "alias gimp-latest=\"make -f '$(PWD)'/Makefile run\"" >> ~/.bashrc

~/.gimp-latest-config:
	[ -d ~/.gimp-latest-config ] || mkdir ~/.gimp-latest-config

clean:
	[ ! -d ~/.gimp-latest-config ] || rm -r ~/.gimp-latest-config
	docker rmi gimp-latest
