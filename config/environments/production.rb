FeedFiction::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = false


  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to nil and saved in location specified by config.assets.prefix
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )

  ENV["SMTP_USERNAME"] = 'yossi@feedfiction.com'
  ENV["SMTP_PASSWORD"] = 'qiL_WrPtlBHpyszuWfZGVA'
  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.mandrillapp.com",
    port: 25,
    authentication: "login",
    enable_starttls_auto: true,
    user_name: ENV["SMTP_USERNAME"],
    password: ENV["SMTP_PASSWORD"]
    #openssl_verify_mode => 'none'

  }
  config.action_mailer.default_url_options = { host: "feedfiction.com" }

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5
  ENV['FACEBOOK_APP_ID'] = '244160649037860'
  ENV['FACEBOOK_SECRET'] = 'c7974ab01e76c15d62823eca67f51d2d'
  ENV['INSTAGRAM_ID'] = 'bc404a3290414780a8d79ee241de94af'
  ENV['INSTAGRAM_SECRET'] = 'ead957b38e264addb8fd47d8aeecf2a9'
  ENV['INSTAGRAM_CALLBACK'] = 'http://feedfiction.com/oauth/instagram/callback'
  ENV["AWS_ACCESS_KEY_ID"] = 'AKIAIKZTOEKGDO6YLPEQ'
  ENV["AWS_SECRET_ACCESS_KEY"] = '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'
  ENV["AWS_S3_BUCKET"] = 'feedfiction-images'
  ENV["AWS_S3_URL"] = "http://#{ENV["AWS_S3_BUCKET"]}.s3.amazonaws.com"
  ENV["ROOT_URL"] = "http://feedfiction.com"
  
end
