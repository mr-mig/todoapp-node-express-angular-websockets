#!/bin/bash
# The script will upload the project to the server and restart the service

# $1 is a hostname, e.g. ubuntu@mrmig.info
tar -cvzf nodeserver.tar.gz ./
scp -i ~/.ssh/id_rsa -r nodeserver.tar.gz ubuntu@toptal.mrmig.info:/usr/local/nodejs/toptal
ssh -i ~/.ssh/id_rsa $1 << 'ENDSSH'
cd /usr/local/nodejs/toptal
tar -xvf nodeserver.tar.gz
sudo cp nodeserver.conf /etc/init/
sudo service nodeserver restart
ENDSSH