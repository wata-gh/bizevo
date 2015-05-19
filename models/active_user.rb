class ActiveUser < ActiveLdap::Base
  ldap_mapping :dn_attribute => "cn", :prefix => ''

  def self.authenticate email, pass
    if Padrino.env == :development || Padrino.env == :test
      a = User.find_by :name => email
      return nil unless a
      au = MockActiveUser.new
      au.description = a.psnal_cd
      au.department = a.mst_blg_cd
      au.sAMAccountName = email
      return au
    end
    ldap = Net::LDAP.new
    ldap.host = LDAP_CONFIG[:host]
    ldap.port = LDAP_CONFIG[:port]
    ldap.auth "ACTIVEWORK\\#{email}", pass
    if ldap.bind
      au = self.find_user email
      return nil unless au
      u = User.where(:name => au.sAMAccountName).first_or_initialize
      u.name = au.sAMAccountName
      u.psnal_cd = au.description
      u.mst_blg_cd = au.department.split(':')[0]
      u.save!
      return au
    end
    nil
  end

  def self.find_user name
    return nil if name.blank?
    if Padrino.env != :development && Padrino.env != :test
      self.find(:first, filter: {:sAMAccountName => name})
    else
      a = User.find_by :name => name
      return nil unless a
      au = MockActiveUser.new
      au.description = a.psnal_cd
      au.department = a.mst_blg_cd
      au.sAMAccountName = name
      au
    end
  end

  def id
    self.user.id
  end

  def name
    self.sAMAccountName
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
    attr_accessor :description, :sAMAccountName, :department
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
