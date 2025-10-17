require "laserblob/version"
require "laserblob/engine"
require "laserblob/blob_helpers"
require "laserblob/storage/filesystem"
require "laserblob/storage/s3"
require "laserblob/model_extensions"

# Require models explicitly since they're in a gem
require_relative "../app/models/laserblob/blob"
require_relative "../app/models/laserblob/attachment"
require_relative "../app/models/laserblob/blob/image"
require_relative "../app/models/laserblob/blob/video"
require_relative "../app/models/laserblob/blob/pdf"

module LaserBlob
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
          LaserBlob::Storage::Filesystem.new(config)
        when 's3'
          LaserBlob::Storage::S3.new(config)
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
