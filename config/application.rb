require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module ClassStatus
	class Application < Rails::Application
		config.autoload_paths += %W(#{config.root}/texters)
		# Add the fonts path
		config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

		# Precompile additional assets
		config.assets.precompile += %w( .svg .eot .woff .ttf )
	end
end
