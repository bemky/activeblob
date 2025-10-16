require "activeblob/version"
require "activeblob/engine"
require "activeblob/blob_helpers"
require "activeblob/storage/filesystem"
require "activeblob/storage/s3"
require "activeblob/model_extensions"

module ActiveBlob
  mattr_accessor :storage_config

  class << self
    def configure
      yield self if block_given?
    end

    def storage
      @storage ||= begin
        config = storage_config || default_storage_config
        case config[:storage]
        when 'filesystem', nil
          ActiveBlob::Storage::Filesystem.new(config)
        when 's3'
          ActiveBlob::Storage::S3.new(config)
        else
          raise "Unknown storage type: #{config[:storage]}"
        end
      end
    end

    private

    def default_storage_config
      {
        storage: 'filesystem',
        path: Rails.root.join('storage', 'blobs')
      }
    end
  end
end
