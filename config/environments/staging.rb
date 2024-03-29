FeedFiction::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = false

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  config.assets.compile = true

  # Generate digests for assets URLs
  config.assets.digest = true

  # Expands the lines which load the assets
  #config.assets.debug = true
  # Generate digests for assets URLs
  #config.assets.digest = true

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

  ENV["SMTP_USERNAME"] = 'yossish73'
  ENV["SMTP_PASSWORD"] = 'a1a2a3'
  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "sout.zahav.net.il",
    domain: 'feedfiction.com',
    authentication: "plain",
    enable_starttls_auto: false,
    user_name: ENV["SMTP_USERNAME"],
    password: ENV["SMTP_PASSWORD"]
    #openssl_verify_mode => 'none'

  }
  config.action_mailer.default_url_options = { host: "feedfiction.herokuapp.com" }

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
  ENV['FACEBOOK_APP_ID'] = '117474545075929'
  ENV['FACEBOOK_SECRET'] = '54875f42c706b1079c10b19a48b29f25'
  ENV['INSTAGRAM_ID'] = '604e4964a81a488292a95f5c9573c827'
  ENV['INSTAGRAM_SECRET'] = 'e812eb59c7964df38d708c87a695472a'
  ENV['INSTAGRAM_CALLBACK'] = 'http://feedfiction-demo.herokuapp.com/oauth/instagram/callback'
  ENV["AWS_ACCESS_KEY_ID"] = 'AKIAIKZTOEKGDO6YLPEQ'
  ENV["AWS_SECRET_ACCESS_KEY"] = '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'
  ENV["AWS_S3_BUCKET"] = 'staging-feedfiction-images'
  ENV["AWS_S3_URL"] = "https://#{ENV["AWS_S3_BUCKET"]}.s3.amazonaws.com"
end
