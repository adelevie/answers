#!/bin/sh

# cp necessary base files from .example files
/bin/cp Vagrantfile.example Vagrantfile
/bin/cp .databag_secret.example .databag_secret
/bin/cp kitchen/nodes/localhost.json.example kitchen/nodes/localhost.json


# setup vm and provision
VAGRANT_MEMORY=4096 /usr/bin/vagrant up


# run tests on vm
/usr/bin/vagrant ssh -c 'cd answers && RAILS_ENV=test rake db:migrate spec'
echo "Initial setup complete if the above tests passed with '0 failures'."


# open answers app in default web browser if osx
if [[ `uname` == 'Darwin' ]]; then
	echo "opening Answers Platform using the default browswer..."
	/usr/bin/open http://localhost:9080
fi
