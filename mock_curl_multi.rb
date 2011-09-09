require 'curl-multi'
require 'mocks'

CURL_NEW = Curl::Multi.method(:new) unless defined? CURL_NEW

#
# Example:
#   mock_curl_next_request { |req|
#     req.add_chunk("<xml>junk</xml>") 
#     req.do_success
#   }
#
def mock_curl_next_request(&block) 
  Curl::Multi.stub!(:new).and_return {
  cm = CURL_NEW.call
  cm.stub!(:size).and_return {
    req = cm.instance_variable_get(:@handles).first
    if req
      block.call(req)
    end
    0
  }
  cm
}

end

def unmock_curl
  $mock_chunk = nil if $mock_chunk
  Curl::Multi.stub!(:new).and_return { CURL_NEW.call }
end