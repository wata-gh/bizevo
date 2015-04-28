class ActiveUser < ActiveLdap::Base
  ldap_mapping :dn_attribute => "cn", :prefix => ''

  def self.authenticate email, pass
    if Padrino.env == :development
      a = Account.find_by :name => email
      return nil unless a
      au = MockActiveUser.new
      au.description = '000000'
      au.sAMAccountName = email.split('@').first
      return au
    end
    ldap = Net::LDAP.new
    ldap.host = LDAP_CONFIG[:host]
    ldap.port = LDAP_CONFIG[:port]
    ldap.auth "ACTIVEWORK\\#{email}", pass
    return self.find_user email if ldap.bind
    nil
  end

  def self.find_user name
    return nil if name.blank?
    if Padrino.env != :development
      self.find(:first, filter: {:sAMAccountName => name})
    else
      au = MockActiveUser.new
      au.description = '000000'
      au.sAMAccountName = name
      au
    end
  end
  def post
    memberOf[0].rdns[0]['CN']
  end

  class MockActiveUser
    attr_accessor :description, :sAMAccountName
    def id
      self.account.id
    end
    def name
      self.sAMAccountName
    end
    def post
      self.account.role
    end
    def account
      Account.find_by :name => self.sAMAccountName
    end
  end
end
