# encoding: UTF-8

class Password < Base

  def response(env)
    @pwd_request = PasswordRequest.new.parse_from(env["rack.input"])
    username = @pwd_request.username
    password = @pwd_request.password
    user = User.find(username)
    token = user.generate_token
    user.update(:password => password, :token => token)
    @response_rusult = pwd_response_build token

    [200, {'Content-Type' => 'application/octet-stream'}, @response_rusult ]
  end

  protected

    def pwd_response_build(token)
      @pwd_response = PasswordResponse.new
      @pwd_response.token = token
      @pwd_response.error = error_gpb_info
      return @pwd_response.serialize_to_string
    end

end