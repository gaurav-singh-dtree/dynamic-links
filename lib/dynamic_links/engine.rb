module DynamicLinks
  class Engine < ::Rails::Engine
    isolate_namespace DynamicLinks
    initializer "dynamic_links.assets.precompile" do |app|
      app.config.assets.precompile += %w( actions.js)
    end
  end
end
