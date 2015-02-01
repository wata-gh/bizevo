SimpleCov.adapters.define 'padrino' do

  add_filter '/spec/'
  add_filter '/vendor/'

  # サブアプリケーションの一覧
  sub_apps = %w(app)
  sub_apps.each do |sub_app|
    # コントローラグループ
    add_group "#{sub_app}/controllers", "#{sub_app}/controllers"

    # ヘルパーグループ
    add_group "#{sub_app}/helpers", "#{sub_app}/helpers"

  end

  add_group 'Controllers', 'controllers'
  add_group 'Models', 'models'
  add_group 'Libraries', 'lib'
end
