module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter params
      page = params['page'].present? ? params['page'].to_i : 1
      res = self.page(page).where nil
      params.each do |k, v|
        if v.present?
          res = res.where(k => v) if res.column_names.include? k
        end
      end
      res
    end
  end
end
