# Helper methods defined here can be accessed in any controller or view in the application
require 'json'
require 'pp'

module Bizevo
  class App
    module KiitaApiHelper
      # def simple_helper_method
      # ...
      # end
      def output body
        content_type 'application/json; charset=utf-8'
        JSON.generate body
      end
    end

    helpers KiitaApiHelper
  end
end
