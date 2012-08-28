### Generated by rprotoc. DO NOT EDIT!
### <proto file: RegAttrGPB.proto>
# import "ErrorGPB.proto";
# 
# message RegAttrRequest
# {
# 	required string username = 1;
#     required string token = 2;
# 	required int32 attribute = 3;
# }
# 
# message RegAttrResponse
# {
#     optional ErrorGPB error = 1;
# }

require 'protobuf/message/message'
require 'protobuf/message/enum'
require 'protobuf/message/service'
require 'protobuf/message/extend'

require 'pb/ErrorGPB.pb'
class RegAttrRequest < ::Protobuf::Message
  defined_in __FILE__
  required :string, :username, 1
  required :string, :token, 2
  required :int32, :attribute, 3
end
class RegAttrResponse < ::Protobuf::Message
  defined_in __FILE__
  optional :ErrorGPB, :error, 1
end