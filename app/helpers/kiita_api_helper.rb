require 'json'

module Bizevo
  class App
    module KiitaApiHelper
      ##
      # エラーレスポンス返却
      #
      def err_res v = {}, root_opt = {}
        content_type 'application/json; charset=utf-8'
        {is_success: 0}.merge(root_opt).merge({error: v}).to_json
      end

      ##
      # 正常レスポンス返却
      #
      def suc_res v = {}, root_opt = {}
        content_type 'application/json; charset=utf-8'
        {is_success: 1}.merge(root_opt).merge({results: v}).to_json
      end
    end

    helpers KiitaApiHelper
  end
end
