# encoding: UTF-8

class Login < Base

  def response(env)
    @login_request = LoginRequest.new.parse_from(env["rack.input"])
    username = @login_request.username.downcase
    password = @login_request.password

    user = User.find username
    if user
      if user.auth_login(password)
        @response_rusult = login_response_build(user.token, error_gpb_info)
      else
        @response_rusult = login_response_build("", error_gpb_info(LOGIC_ERROR_INFOS[:code1][:text], LOGIC_ERROR_INFOS[:code1][:code]))
      end
    else
      @response_rusult = login_response_build("", error_gpb_info(LOGIC_ERROR_INFOS[:code3][:text], LOGIC_ERROR_INFOS[:code3][:code]))
    end
    [200, {'Content-Type' => 'application/octet-stream'}, @response_rusult ]
  end

  protected

    def login_response_build(token, error_gpb)
      @login_response = LoginResponse.new
      @login_response.token = token
      @login_response.error = error_gpb
      return @login_response.serialize_to_string
    end

    

end