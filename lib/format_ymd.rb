class String
  def format_ymd
    self.gsub(/(\d{4})(\d{2})(\d{2})/, '\1/\2/\3')
  end
end
