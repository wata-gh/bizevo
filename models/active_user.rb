class ActiveUser < ActiveLdap::Base
  ldap_mapping :dn_attribute => "cn", :prefix => ''

  def self.authenticate email, pass
    if Padrino.env == :development || Padrino.env == :test
      a = User.find_by :name => email
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
    if ldap.bind
      u = self.find_user email
      User.create name: u.sAMAccountName, psnal_cd: u.description unless User.find_by :name => u.sAMAccountName
      return u
    end
    nil
  end

  def self.find_user name
    return nil if name.blank?
    if Padrino.env != :development && Padrino.env != :test
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

  def user
    User.find_by :name => self.sAMAccountName
  end

  def redmine_user
    @remine_user ||= Redmine::User.find_by :mail => "#{self.sAMAccountName}@active.co.jp"
  end

  class MockActiveUser
    attr_accessor :description, :sAMAccountName
    def id
      self.user.id
    end
    def name
      self.sAMAccountName
    end
    def post
      self.user.role
    end
    def user
      User.find_by :name => self.sAMAccountName
    end
    def redmine_user
      @remine_user ||= Redmine::User.find_by :mail => "#{self.sAMAccountName}@active.co.jp"
    end
  end
end
