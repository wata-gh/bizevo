require 'active_ldap'

config = YAML.load_file(File.join('config', 'ldap.yml'))
LDAP_CONFIG = config[RACK_ENV.to_sym]
ActiveLdap::Base.setup_connection LDAP_CONFIG
