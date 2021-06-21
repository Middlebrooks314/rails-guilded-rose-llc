class Api::V1::CredentialsManager < ApplicationController

  def base64encode(username, password)
    Base64.encode64("#{username}:#{password}")
  end
end
