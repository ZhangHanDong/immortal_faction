$: << "../../config" << "./config"
require 'boot'

class SignUp < ::Goliath::API
  use Goliath::Rack::Params

  def response(env)
  	request = Rack::Request.new(env)
    @sign_up_request = SignUpRequest.new.parse_from(env["rack.input"])

    @response_rusult = response_build


    [200, {'Content-Type' => 'application/octet-stream'}, @response_rusult ]
  end


  def response_build
    user = User.new
    user.new_user_id

    @sign_up_response = SignUpResponse.new
    @sign_up_response.username = user.uniq_name

    @error_gpb = ErrorGPB.new
    @error_gpb.error_text = "none"
    @error_gpb.error_code = 0

    @sign_up_response.error = @error_gpb

    return @sign_up_response.serialize_to_string
  end


end