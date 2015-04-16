class String
  def format_ymd d='/'
    self.gsub(/(\d{4})(\d{2})(\d{2})/, "\\1#{d}\\2#{d}\\3")
  end
end
