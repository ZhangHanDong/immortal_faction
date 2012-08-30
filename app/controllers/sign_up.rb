class SignUp < ::Goliath::API
  use Goliath::Rack::Validation::RequestMethod, %w(POST GET)

  def response(env)

    if sign_up? env
      @sign_up_request = SignUpRequest.new.parse_from(env["rack.input"])
      username = User.create
      Device.update(:device_type => @sign_up_request.device_type, :device_code => @sign_up_request.mac_address)
      @response_rusult = sign_up_response_build username
    elsif password_info? env
      @pwd_request = PasswordRequest.new.parse_from(env["rack.input"])
      username = @pwd_request.username
      password = @pwd_request.password
      user = User.find(username)
      token = user.generate_token
      user.update(:password => password, :token => token)
      @response_rusult = pwd_response_build token
    end

    [200, {'Content-Type' => 'application/octet-stream'}, @response_rusult ]
  end

  protected

    def sign_up?(env);       env['REQUEST_METHOD'] == 'GET';  end

    def password_info?(env); env['REQUEST_METHOD'] == 'POST'; end

    def error_gpb_info(error_text="", error_code=0)
      @error_gpb = ErrorGPB.new
      @error_gpb.error_text = ""
      @error_gpb.error_code = 0
      return @error_gpb
    end

    def sign_up_response_build(username)
      @sign_up_response = SignUpResponse.new
      @sign_up_response.username = username
      @sign_up_response.error = error_gpb_info
      return @sign_up_response.serialize_to_string
    end

    def pwd_response_build(token)
      @pwd_response = PasswordRequest.new
      @pwd_response.token = token
      @pwd_response.error = error_gpb_info
      return @pwd_response.serialize_to_string
    end
end