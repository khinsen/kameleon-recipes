#/bin/bash
set -e
echo "libguestfs0     libguestfs/update-appliance     boolean false" | debconf-set-selections
echo "mdadm   mdadm/initrdstart       string  none" | debconf-set-selections
apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends git virtualbox linux-headers-amd64 socat qemu-utils ruby-dev ruby-childprocess polipo pigz linux-headers-$(uname -r) netcat eatmydata
apt-get install -y -t jessie-backports libguestfs-tools
apt-get install -y dirmngr
gem install --no-ri --no-rdoc kameleon-builder
mv /bin/gzip /bin/gzip.OLD
ln -s /usr/bin/pigz /bin/gzip
cd /tmp