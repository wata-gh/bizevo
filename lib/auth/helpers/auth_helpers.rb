module Bizevo
  module Auth
    module Helpers
      module AuthHelpers
        def logged_in?
          !current_user.nil?
        end

        def current_user
          @current_user ||= login_from_session
        end

        def set_current_user user
          session[:psnal_cd] = user ? user.description : nil
          session[:sAMAccountName] = user ? user.sAMAccountName : nil
          @current_user = user
        end

        def allowed?
          access_control.allowed?(current_user, request.path_info)
        end

        def login_required
          unless allowed?
            access_denied
          end
        end

        private
        def access_denied
          redirect 'auth/login'
        end
        def login_from_session
          ActiveUser.find_user session[:sAMAccountName]
        end
      end
    end
  end
end
