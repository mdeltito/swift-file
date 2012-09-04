require "swift_file/version"
require "swift_file/swift_upload"

module SwiftFile
  class << self
    attr_accessor :swift_file, :swift_file_group, :swift_file_password

    def self.upload
      sf = SwiftFile::SwiftUpload.new({
        :file => @swift_file,
        :group => @swift_file_group || nil,
        :password => @swift_file_password || nil
      })

      sf.upload
      sf.url
    end
  end
end

