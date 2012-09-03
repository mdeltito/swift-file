require 'curb'

module SwiftFile
  class SwiftUpload
    @@swiftfile_host      = "https://www.swiftfile.net"
    @@swiftfile_endpoint  = ""
    @@swiftfile_cookie    = "/tmp/swift_file.cookie"

    attr_accessor :file, :group, :url

    def initialize(params)
      # ensure we've been passed a valid file
      if File.readable?(params[:file]) && File.file?(params[:file])
        @file = params[:file]
      else
        raise "Invalid file supplied for new SwiftUpload"
      end

      @group = params[:group] || ''
      @password = params[:password] || ''
    end

    def transfer
      # start a session by requesting the url via GET
      begin
        client.perform
      rescue Curl::Err => e
        raise "Connection failed: #{e}"
      end

      # post the file and capture the resulting url
      begin
        client.multipart_form_post = true
        client.http_post(
          Curl::PostField.file('file1', "#{@file.path}"),
          Curl::PostField.content('file_group[name]', @group),
          Curl::PostField.content('file_group[password]', @password),
          Curl::PostField.content('file_group_expiration', '1m')
        )

        @url = client.last_effective_url
      rescue Curl::Err => e
        raise "Upload failed: #{e}"
      ensure
        client.close
      end

      @url
    end


    private
    def client
      if !@client
        url = "#{@@swiftfile_host}/#{@@swiftfile_endpoint}"
        @client = Curl::Easy.new(url) do |curl|
          # curl.verbose= true
          curl.follow_location = true
          curl.enable_cookies = true
          curl.cookiejar = @@swiftfile_cookie
          curl.cookiefile = @@swiftfile_cookie
        end
      end
      @client
    end
  end
end
