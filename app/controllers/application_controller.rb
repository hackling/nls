class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV.fetch('ADMIN_USERNAME'),
    password: ENV.fetch('ADMIN_PASSWORD')

  protect_from_forgery
end
