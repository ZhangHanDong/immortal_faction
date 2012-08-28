$: << "../../config" << "./config"
require 'boot'

class Login < ::Goliath::API
  use Goliath::Rack::Params
  use Goliath::Rack::Validation::RequestMethod, %w(POST)
  use Goliath::Rack::Heartbeat

  def response(env)
    @login_request = LoginRequest.new.parse_from(env["rack.input"])
    username = @login_request.username
    password = @login_request.password

    sha_password = If::RedisDistributed.node.hmget("accounts:user_lists:#{username}", "password")

    if sha_password
      if sha_password == User.generate_password(password)
      	token = If::RedisDistributed.node.hmget("accounts:user_lists:#{username}", "token")
        @response_rusult = login_response_build(token, error_gpb_info)
      else
        @response_rusult = login_response_build("", error_gpb_info("password invalid", 401))
      end
    else
      @response_rusult = login_response_build("", error_gpb_info("", 401))
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

    def error_gpb_info(text="", code=0)
      @error_gpb = ErrorGPB.new
      @error_gpb.error_text = text
      @error_gpb.error_code = code
      return @error_gpb
    end

end