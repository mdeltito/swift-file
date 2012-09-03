require 'spec_helper'

describe SwiftUpload do
  it "should be able to upload test file" do
    f = File.new(File.dirname(__FILE__) + '/test_file.txt', 'rb')
    sf = SwiftFile::SwiftUpload.new({:file => f})

    sf.transfer
    sf.url.should =~ /^https/
  end
end
