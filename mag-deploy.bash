
#!/bin/bash

# export http_proxy=http://135.245.192.7:8000 && export https_proxy=http://135.245.192.7:8000
# modprobe ip_tables && sudo echo 'ip_tables' >> /etc/modules 
clab destroy -t topo-nokia-MAG-lab.yaml
rm *.yaml*
rm *.tmpl*

mkdir startup-config
wget --no-cache -O startup-config/aggUPF-01.cfg https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/startup-config/aggUPF-01.cfg
wget --no-cache -O startup-config/aggUPF-02.cfg https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/startup-config/aggUPF-02.cfg
wget --no-cache -O startup-config/magC-01.cfg https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/startup-config/magC-01.cfg
wget --no-cache -O startup-config/magC-02.cfg https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/startup-config/magC-02.cfg
wget --no-cache -O startup-config/pe-01.cfg https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/startup-config/pe-01.cfg


docker pull ghcr.io/asadarafat/topoviewer:development
docker pull ghcr.io/asadarafat/bngblaster:main
docker pull ghcr.io/asadarafat/freeradius:main
docker image prune -f

wget --no-cache https://raw.githubusercontent.com/asadarafat/topoViewer/master/rawTopoFile/clab-topo-export-template/clab-topo-cytoscape.tmpl

wget --no-cache https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/topo-nokia-MAG-lab.yaml

mkdir radius-config
wget --no-cache -O radius-config/clients.conf https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/radius-config/clients.conf
wget --no-cache -O radius-config/users https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/radius-config/users

clab deploy -t topo-nokia-MAG-lab.yaml --export-template clab-topo-cytoscape.tmpl 

#
#
