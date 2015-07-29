require_relative '../config/requirements'

settings = Settings.new('settings.yml')

application = Application.new(settings)
application.pull_user_data
