require "rails"

module ActiveBlob
  class Engine < ::Rails::Engine
    isolate_namespace ActiveBlob

    config.autoload_paths << File.expand_path('../../app/models', __dir__)

    config.generators do |g|
      g.test_framework :test_unit, fixture: false
    end

    initializer "activeblob.active_record", before: :load_config_initializers do
      ActiveSupport.on_load(:active_record) do
        require "activeblob/model_extensions"
        ActiveRecord::Base.include(ActiveBlob::ModelExtensions)
      end
    end
  end
end
