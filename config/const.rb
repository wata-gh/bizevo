# api config
app_config = {}
%w/system slack/.map(&:to_sym).each do |app|
  config = YAML.load_file(File.join('config', "#{app}_config.yml"))
  app_config[app] = (config[:common] || {}).deep_merge(config[RACK_ENV.to_sym] || {}).deep_symbolize_keys
end
APP_CONFIG = app_config.merge(app_config[:system])
