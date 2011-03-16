# Howdy
require 'spec/mocks'

TCP_NEW = TCPSocket.method(:new) unless defined? TCP_NEW

#
# Example:
#   mock_tcp_next_request("<xml>junk</xml>")
#
class DummyTCPSocket

  def readline(some_text = nil)
    return @canned_response    
  end

  def flush
  end

  def write(some_text = nil)
  end

  def set_canned(response)
     @canned_response = response
  end

end

def mock_tcp_next_request(string) 
  TCPSocket.stub!(:new).and_return {
    cm = DummyTCPSocket.new
    cm.set_canned(string)
    cm
  }
end

def unmock_tcp
  TCPSocket.stub!(:new).and_return { TCP_NEW.call }
end