require 'base64'

def basic_auth_for_app
  username = ENV.fetch "ADMIN_USERNAME"
  password = ENV.fetch "ADMIN_PASSWORD"

  "Basic #{Base64.strict_encode64 [username, password].join(":")}"
end
