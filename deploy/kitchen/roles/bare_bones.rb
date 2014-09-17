name "bare-bones"
description "The base role for all systems"
run_list ["apt", "build-essential", "fail2ban", "git", "hostname", "libqt4", "ntp", "openssl", 'rbenv', 'ssl_certificate', "sudo", "users_solo::admins"]