class ActiveUser < ActiveLdap::Base
  ldap_mapping :dn_attribute => "cn", :prefix => ''

  def self.authenticate email, pass
    ldap = Net::LDAP.new
    ldap.host = LDAP_CONFIG[:host]
    ldap.port = LDAP_CONFIG[:port]
    ldap.auth "ACTIVEWORK\\#{email}", pass
    puts email
    puts pass
    return self.find_user email if ldap.bind
    nil
  end

  def self.find_user name
    return nil if name.blank?
    self.find(:first, filter: {:sAMAccountName => name})
  end
  def post
    memberOf[0].rdns[0]['CN']
  end
end
