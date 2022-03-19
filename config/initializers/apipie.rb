Apipie.configure do |config|
  config.app_name                = "QuizCenterApi"
  config.api_base_url            = ""
  config.doc_base_url            = "/doc"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.default_locale          = 'en'
  config.languages               = ['en']
  config.validate                = false
end
