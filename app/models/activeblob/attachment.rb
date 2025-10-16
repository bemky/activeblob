module ActiveBlob
  class Attachment < ActiveRecord::Base
    self.table_name = 'attachments'
    self.inheritance_column = nil

    belongs_to :blob, class_name: 'ActiveBlob::Blob'
    belongs_to :record, polymorphic: true

    before_validation { self.order ||= 0 }
    before_save :default_filename

    validates_uniqueness_of :blob_id, scope: [:record_id, :record_type, :type, :filename], message: " already attached", if: :record_id

    delegate :size, :content_type, :sha1, :extension, to: :blob

    def url(**options)
      options[:filename] ||= filename
      blob.url(**options)
    end

    def file=(file)
      self.filename ||= ActiveBlob::BlobHelpers.filename_from_file(file)
      self.blob = ActiveBlob::Blob.new(file: file)
    end

    def url=(url)
      file = ActiveBlob::Blob.download_url(url)
      self.filename = file.original_filename
      self.blob = ActiveBlob::Blob.create!(file: file)
    end

    def default_filename
      self.filename ||= [self.type, SecureRandom.hex(10)].join("-")
    end

    def open(basename: nil, &block)
      basename ||= [File.basename(filename), File.extname(filename)]
      blob.open(basename: basename, &block)
    end
  end
end
