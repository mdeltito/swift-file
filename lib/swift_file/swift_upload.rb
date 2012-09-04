require 'curb'

module SwiftFile
  class SwiftUpload
    SWIFTFILE_HOST              = 'https://www.swiftfile.net'
    SWIFTFILE_ENDPOINT          = ''
    SWIFTFILE_COOKIE            = '/tmp/swift_file.cookie'
    SWIFTFILE_EXPIRY_OPTIONS    =  %w(1m 1w 1d 1h)
    SWIFTFILE_EXPIRY_DEFAULT    = '1d'

    attr_accessor :files, :group, :expiry, :url

    def initialize(params)
      @files    = params[:files] || []
      @group    = params[:group] || ''
      @password = params[:password] || ''

      if params[:expiry] && SWIFTFILE_EXPIRY_OPTIONS.include?(params[:expiry])
        @expiry = params[:expiry]
      else
        @expiry = SWIFTFILE_EXPIRY_DEFAULT
      end
    end

    def add_file(file)
      @files << file unless @files.include?(file)
    end

    def transfer
      if @files.empty?
        raise 'No files supplied for uploed'
      end

      # start a session by requesting the url via GET
      begin
        client.perform
      rescue Curl::Err => e
        raise "Connection failed: #{e}"
      end

      # post the file and capture the resulting url
      begin
        client.multipart_form_post = true
        client.http_post(form)

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
        url = "#{SWIFTFILE_HOST}/#{SWIFTFILE_ENDPOINT}"
        @client = Curl::Easy.new(url) do |curl|
          # curl.verbose= true
          curl.follow_location = true
          curl.enable_cookies = true
          curl.cookiejar = SWIFTFILE_COOKIE
          curl.cookiefile = SWIFTFILE_COOKIE
        end
      end
      @client
    end

    def form
      fields = []
      @files.each_with_index do |file, idx|
        fields << Curl::PostField.file("file#{idx+1}", "#{file.path}")
      end

      fields << Curl::PostField.content('file_group[name]', @group)
      fields << Curl::PostField.content('file_group[password]', @password)
      fields << Curl::PostField.content('file_group_expiration', @expiry)
      fields
    end
  end
end
