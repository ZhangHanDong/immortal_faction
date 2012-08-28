$: << "../../config" << "./config"
require 'boot'

class SignUp < ::Goliath::API
  use Goliath::Rack::Params
  use Goliath::Rack::Validation::RequestMethod, %w(POST GET)

  def response(env)
    user = User.new

    if sign_up? env
      username = user.build
      @sign_up_request = SignUpRequest.new.parse_from(env["rack.input"])
      user.device_info_save(@sign_up_request.mac_address, @sign_up_request.device_type)
      @response_rusult = sign_up_response_build username
    elsif password_info? env
      @pwd_request = PasswordRequest.new.parse_from(env["rack.input"])
      username = @pwd_request.username
      password = @pwd_request.password
      sha_password = User.generate_password password
      token = user.generate_token
      user.save(username, [['password', sha_password], ['token', token]])
      @response_rusult = pwd_response_build token
    end

    [200, {'Content-Type' => 'application/octet-stream'}, @response_rusult ]
  end

  protected

    def sign_up?(env);       env['REQUEST_METHOD'] == 'GET';  end

    def password_info?(env); env['REQUEST_METHOD'] == 'POST'; end


    def sign_up_response_build(username)
      @sign_up_response = SignUpResponse.new
      @sign_up_response.username = username

      @error_gpb = ErrorGPB.new
      @error_gpb.error_text = ""
      @error_gpb.error_code = 0

      @sign_up_response.error = @error_gpb

      return @sign_up_response.serialize_to_string
    end

    def pwd_response_build(token)
      @pwd_response = PasswordRequest.new
      @pwd_response.token = token

      @error_gpb = ErrorGPB.new
      @error_gpb.error_text = ""
      @error_gpb.error_code = 0

      return @pwd_response.serialize_to_string
    end
end