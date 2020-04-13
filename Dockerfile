FROM  fedora:31

RUN  set -ex; \
dnf makecache; \
dnf module -y disable gimp; \
dnf install -y gimp gimp-help-en_GB libcanberra-gtk2 iso-codes; \
dnf clean all

RUN set -ex; \
adduser sam; \
usermod -a -G wheel sam; \
echo '%wheel	ALL=(ALL)	NOPASSWD: ALL' > /etc/sudoers.d/wheel

USER sam

WORKDIR /home/sam
