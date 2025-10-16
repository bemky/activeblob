require_relative "lib/activeblob/version"

Gem::Specification.new do |spec|
  spec.name        = "activeblob"
  spec.version     = ActiveBlob::VERSION
  spec.authors     = ["Ben Ehmke"]
  spec.email       = ["ben@ehmke.com"]
  spec.homepage    = "https://github.com/bemky/activeblob"
  spec.summary     = "Content-addressable blob storage for Rails applications"
  spec.description = "ActiveBlob provides a Blob model with SHA1-based deduplication, polymorphic attachments, and support for multiple storage backends (filesystem, S3). Includes automatic metadata extraction for images, videos, and PDFs."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/bemky/activeblob"
  spec.metadata["changelog_uri"] = "https://github.com/bemky/activeblob/blob/master/CHANGELOG.md"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.required_ruby_version = ">= 2.7.0"

  spec.add_dependency "rails", ">= 6.1"
  spec.add_dependency "mini_mime", "~> 1.0"

  # Optional dependencies for blob type processing
  spec.add_development_dependency "ruby-vips"
  spec.add_development_dependency "streamio-ffmpeg"
  spec.add_development_dependency "pdf-reader"
end
