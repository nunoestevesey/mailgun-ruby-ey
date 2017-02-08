require 'base64'

module Railgun

  class Attachment < StringIO

    attr_reader :source_filename, :content_type, :path

    def initialize(attachment, *args)
      @path = ''
      if args.detect { |opt| opt[:inline] }
        basename = @source_filename = attachment.cid
      else
        basename = @source_filename = attachment.filename
      end

      @content_type = attachment.content_type.split(';')[0]

      super Base64.decode64 attachment.body.encoded
    end

  end
end
