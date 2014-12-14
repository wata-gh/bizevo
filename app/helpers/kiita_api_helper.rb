require 'json'

module Bizevo
  class App
    module KiitaApiHelper
      def output body
        content_type 'application/json; charset=utf-8'
        JSON.generate body
      end
    end

    helpers KiitaApiHelper
  end
end
