# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( frontend/jquery.min.js )
Rails.application.config.assets.precompile += %w( frontend/common.js )
Rails.application.config.assets.precompile += %w( frontend/slick.min.js )
Rails.application.config.assets.precompile += %w( frontend/home.js )
Rails.application.config.assets.precompile += %w( admin_login.css )
Rails.application.config.assets.precompile += %w( admin_login.js )
Rails.application.config.assets.precompile += %w( admin.css )
Rails.application.config.assets.precompile += %w( admin.js )
Rails.application.config.assets.precompile += %w( admin_university.js )
Rails.application.config.assets.precompile += %w( frontend/users.js )
Rails.application.config.assets.precompile += %w( frontend/message.js )
Rails.application.config.assets.precompile += %w( jquery.validate.min.js )
Rails.application.config.assets.precompile += %w( frontend/group.js )
Rails.application.config.assets.precompile += %w( frontend/jquery.raty.js )
Rails.application.config.assets.precompile += %w( frontend/easyScrollDots.js )
Rails.application.config.assets.precompile += %w( frontend/lightbox.min.js )
