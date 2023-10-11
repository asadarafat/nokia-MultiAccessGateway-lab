
#!/bin/bash

# export http_proxy=http://135.245.192.7:8000 && export https_proxy=http://135.245.192.7:8000
# modprobe ip_tables && sudo echo 'ip_tables' >> /etc/modules 
clab destroy -t topo-nokia-MAG-lab.yaml
rm *.yaml*
rm *.tmpl*

mkdir license
touch license/license-sros23.txt
touch license/mag-c23.lic

mkdir startup-config
wget --no-cache -O startup-config/aggUPF-01.cfg https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/startup-config/aggUPF-01.cfg
wget --no-cache -O startup-config/aggUPF-02.cfg https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/startup-config/aggUPF-02.cfg
wget --no-cache -O startup-config/magC-01.cfg https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/startup-config/magC-01.cfg
wget --no-cache -O startup-config/magC-02.cfg https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/startup-config/magC-02.cfg
wget --no-cache -O startup-config/pe-01.cfg https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/startup-config/pe-01.cfg


docker pull ghcr.io/asadarafat/topoviewer:latest
docker pull ghcr.io/asadarafat/bngblaster:main
docker pull ghcr.io/asadarafat/freeradius:main
docker image prune -f

wget --no-cache https://raw.githubusercontent.com/asadarafat/topoViewer/master/rawTopoFile/clab-topo-export-template-example/clab-topo-new-version-cytoscape.tmpl

wget --no-cache https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/topo-nokia-MAG-lab.yaml

mkdir radius-config
wget --no-cache -O radius-config/clients.conf https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/radius-config/clients.conf
wget --no-cache -O radius-config/users https://raw.githubusercontent.com/asadarafat/nokia-MultiAccessGateway-lab/main/radius-config/users

clab deploy -t topo-nokia-MAG-lab.yaml --export-template clab-topo-new-version-cytoscape.tmpl

echo "Enter the following command to run topoviewer, which web-based GUI for containerlab:"
echo "#############"
echo "#############  docker exec -it clab-nokia-MAGc-lab-topoviewer /opt/topoviewer/topoviewer clab -H 138.203.26.59 -P 8080 -u root -p j0k0w1 -j local-bind/topo-file.json"
echo "#############"
echo "         #### 'root' corresponds to the server username where containerLab is currently operational. "
echo "         #### 'j0k0w1', corresponds to user's password"
echo "         #### '138.203.26.59', corresponds to the server IP address where containerLab is currently operational."
echo "         #### '8080', corresponds to the port where the topoViewer service will be listening."

#
#
