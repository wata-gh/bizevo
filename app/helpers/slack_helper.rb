# Helper methods defined here can be accessed in any controller or view in the application

module Bizevo
  class App
    module SlackHelper
      def slack_authorize_url
        slack_config = APP_CONFIG[:slack]
        "https://slack.com/oauth/authorize?client_id=#{slack_config[:client_id]}&scope=identify,read,post&team=bizevo"
      end
    end
    helpers SlackHelper
  end
end
