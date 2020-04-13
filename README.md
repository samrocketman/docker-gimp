# gimp-latest

This allows me to get the latest stable version of GIMP running from within a
docker container.  I normally run an older LTS version of Ubuntu so using Docker
to get the latest version of GIMP available in Fedora.

# Prepare

    make build

# Run from any directory

Save alias to your bashrc.

    make install-alias

Running `gimp-latest` from any directory will cause the current directory to be
mounted within the container and GIMP to be launched.

### Alias usage

- `gimp-latest` will launch the docker container and connect to my X session.
  It will mount my working directory and open GIMP.
- `gimp-latest shell` will launch the docker container, mount my working
  directory and connect X session.  It opens a shell instead of GIMP.  However,
  because an X session is available you can still launch gimp from the shell by
  running `gimp`.

# Other info

Estimated size is ~600MB.

To upgrade run `make build`.
