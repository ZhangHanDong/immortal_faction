class RegChoice < ::Goliath::API
  use Goliath::Rack::Validation::RequestMethod, %w(POST)

  def response(env)
  	@reg_request = RegAttrRequest.new.parse_from(env["rack.input"])
  	user = User.find(@reg_request.username)
  	if user.token == @reg_request.token
  	  RegAttr.create(user_id: user.id, attribute: @reg_request.attribute)
  	  @response_rusult = reg_response_build error_gpb_info
  	else
      @response_rusult = reg_response_build error_gpb_info('invalid token', '401')
  	end
  	[200, {'Content-Type' => 'application/octet-stream'}, @response_rusult]
  end

  protected
    def error_gpb_info(error_text="", error_code=0)
      @error_gpb = ErrorGPB.new
      @error_gpb.error_text = ""
      @error_gpb.error_code = 0
      return @error_gpb
    end

    def reg_response_build(error_gpb)
      @reg_response = RegAttrResponse.new
      @reg_response.error = error_gpb
      return @reg_response.serialize_to_string
    end

end