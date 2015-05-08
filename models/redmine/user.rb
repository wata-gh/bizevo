module Redmine
  class User < ActiveRecord::Base
    establish_connection configurations[:redmine]
    self.table_name = :users
    self.inheritance_column = :_type_disabled
    has_many :feelings
    has_many :members

    def full_name
      "#{self.lastname} #{self.firstname}"
    end

    def comments_disp_html
      self.content_to_html self.comments
    end
  end
end
