# encoding: UTF-8

class Base < ::Goliath::API
  use Goliath::Rack::Validation::RequestMethod, %w(POST)

  protected

    def error_gpb_info(text="", code=0)
      @error_gpb = ErrorGPB.new
      @error_gpb.error_text = text
      @error_gpb.error_code = code
      return @error_gpb
    end

end