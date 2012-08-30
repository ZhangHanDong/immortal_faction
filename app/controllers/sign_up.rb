# encoding: UTF-8

class SignUp < Base

  def response(env)
      @sign_up_request = SignUpRequest.new.parse_from(env["rack.input"])

      username = User.create
      Device.update(:device_type => @sign_up_request.device_type, :device_code => @sign_up_request.mac_address)
      @response_rusult = sign_up_response_build username

    [200, {'Content-Type' => 'application/octet-stream'}, @response_rusult ]
  end

  protected

    def sign_up_response_build(username)
      @sign_up_response = SignUpResponse.new
      @sign_up_response.username = username
      @sign_up_response.error = error_gpb_info
      return @sign_up_response.serialize_to_string
    end

end