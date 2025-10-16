require "rails"

module ActiveBlob
  class Engine < ::Rails::Engine
    isolate_namespace ActiveBlob

    config.generators do |g|
      g.test_framework :test_unit, fixture: false
    end

    initializer "activeblob.active_record" do
      ActiveSupport.on_load(:active_record) do
        require "activeblob/model_extensions"
        ActiveRecord::Base.include(ActiveBlob::ModelExtensions)
      end
    end
  end
end
