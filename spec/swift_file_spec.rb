require 'spec_helper'

describe SwiftFile do
  it "should be able to upload test file" do
    f = File.new(File.dirname(__FILE__) + '/test_file.txt', 'rb')
    files = Array[f]
    sf = SwiftFile::SwiftUpload.new({:files => files})

    sf.transfer
    sf.url.should =~ /^https/
  end
end
