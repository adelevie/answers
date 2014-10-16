rem NOTE: must execute in a Command prompt as Administrator or else some symbolic links will FAIL

rem cp necessary base files from .example files
cp Vagrantfile.example Vagrantfile
cp .databag_secret.example .databag_secret
cp kitchen\nodes\localhost.json.example  kitchen\nodes\localhost.json

set VAGRANT_MEMORY=4096

vagrant up

vagrant ssh -c "cd answers && RAILS_ENV=test rake db:migrate spec"
start http://localhost:9080