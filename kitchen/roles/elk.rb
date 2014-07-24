name 'elk'
description 'Installs the ELK stack (Elasticsearch, Logstash, and Kibana)'
run_list ['java', 'elasticsearch', 'logstash', 'logstash::agent', 'logstash::server', 'kibana']
#env_run_lists "production" => ["recipe[passenger::config_prod]"], "testing" => ["recipe[passenger::config_test]"]