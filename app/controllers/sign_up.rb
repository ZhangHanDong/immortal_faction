$: << "../../config" << "./config"
require 'boot'

class SignUp < ::Goliath::API
  use Goliath::Rack::Params

  def response(env)
  	request = Rack::Request.new(env)
    device_type, device_code = request.params['device_type'], request.params['device_code']
    #TODO
    # user = User.new
    # user.new_user_id
    # user.save
    # user.device_info_save(device_type, device_code)
    # env.logger.info "device_code -> #{device_code}"
    # env.logger.info user.user_lists.inspect
    # env.logger.info user.device_infos.inspect
    [200, {}, user.uniq_name ]
  end


end