module Bizevo
  module Auth
    module AccessControl
      class << self
        def registered(app)
          app.helpers Bizevo::Auth::Helpers::AuthHelpers
          app.before { login_required }
          app.send(:cattr_accessor, :access_control)
          app.send(:access_control=, Bizevo::Auth::AccessControl::Base.new)
        end

        def login_required

        end
        alias :included :registered
      end

      class Base
        def allowed?(user=nil, path=nil)
          return true if path =~ /auth\//
          return false unless user
          true
        end
      end
    end
  end
end
