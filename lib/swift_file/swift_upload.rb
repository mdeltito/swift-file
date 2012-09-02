require 'curb'

module SwiftFile
  class SwiftUpload
    @@swiftfile_host      = "https://www.swiftfile.net"
    @@swiftfile_endpoint  = ""
    @@swiftfile_cookie    = "/tmp/swift_file.cookie"

    attr_accessor :file, :group, :url

    def initialize(params)
      if File.readable?(params[:file]) && File.file?(params[:file])
        @file = params[:file]
      else
        raise ArgumentError.new('Invalid file supplied for upload')
      end

      @group = params[:group] || ''
      @password = params[:password] || ''
    end


    def upload
      # start a session by requestion the url via GET
      client.perform

      # now post
      client.multipart_form_post = true
      client.http_post(
        Curl::PostField.file('file1', "#{@file.path}"),
        Curl::PostField.content('file_group[name]', @group),
        Curl::PostField.content('file_group[password]', @password),
        Curl::PostField.content('file_group_expiration', '1m')
      )

      @url = client.last_effective_url
      @url
    end

    ##
    private

    def client
      if !@client
        url = "#{@@swiftfile_host}/#{@@swiftfile_endpoint}"
        @client = Curl::Easy.new(url) do |curl|
            # curl.verbose= true
            curl.follow_location = true
            curl.enable_cookies = true
            curl.cookiejar = @@swiftfile_cookie
        end
      end

      @client
    end
  end
end
