# SwiftFile

This gem provides an interface for uploading files to the [SwiftFile](https://www.swiftfile.net) service. There is support for uploading via the command line via the supplied executable `swift_file` as well as a basic API for adding support to your own classes.

## Installation

Most likely you will want to simply install the gem:

    $ gem install swift_file

Or to use this in your projects, add this line to your application's Gemfile:

    gem 'swift_file'

And then execute:

    $ bundle

## Command-line Usage
`swift_file -h`

    Usage: swift_file [options] file1 file2 ...
        -g, --group GROUP                Add this file to a group
        -e, --expires EXPIRY             Set the length of time until this file expires [1m 1w 1d 1h]
        -p[PASSWORD]                     Supply a password to encrypt the file.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
