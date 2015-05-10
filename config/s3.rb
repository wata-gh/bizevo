config = YAML.load_file(File.join('config', 's3.yml'))
S3_CONFIG = config[RACK_ENV.to_sym]
