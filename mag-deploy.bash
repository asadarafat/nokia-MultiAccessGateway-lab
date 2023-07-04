
#!/bin/bash

# export http_proxy=http://135.245.192.7:8000 && export https_proxy=http://135.245.192.7:8000
# modprobe ip_tables && sudo echo 'ip_tables' >> /etc/modules 
clab destroy -t topo-nokia-MAG-lab.yaml
rm *.yaml*
rm *.tmpl*

mkdir radius-config
mkdir startup-config

docker pull ghcr.io/asadarafat/topoviewer:development
docker pull ghcr.io/asadarafat/bngblaster:main
docker pull ghcr.io/asadarafat/freeradius:main
docker image prune -f

wget --no-cache https://raw.githubusercontent.com/asadarafat/topoViewer/master/rawTopoFile/clab-topo-export-template/clab-topo-cytoscape.tmpl

wget --no-cache https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/topo-nokia-MAG-lab.yaml
wget --no-cache -O radius-config/clients.conf https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/radius-config/clients.conf
wget --no-cache -O radius-config/users https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/radius-config/users

clab deploy -t topo-nokia-MAG-lab.yaml --export-template clab-topo-cytoscape.tmpl 

#
#
