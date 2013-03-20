FeedFiction::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
 
  silence_warnings do
      begin
          require 'pry'
          IRB = Pry
      rescue LoadError
      end
  end

  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  #ENV["SMTP_USERNAME"] = 'yossish73'
  #ENV["SMTP_PASSWORD"] = 'a1a2a3'
  ENV["SMTP_USERNAME"] = 'yossi@feedfiction.com'
  ENV["SMTP_PASSWORD"] = 'qiL_WrPtlBHpyszuWfZGVA'
  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

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
  config.action_mailer.default_url_options = { host: "localhost:3000" }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  ENV['FACEBOOK_APP_ID'] = '256183294497269'
  ENV['FACEBOOK_SECRET'] = 'fb2afb7985f715e7e4a8f08d09439efc'
  ENV['INSTAGRAM_ID'] = '20c5ee5df9a64d46bfd73b16d34905b8'
  ENV['INSTAGRAM_SECRET'] = 'e62f6bb7f03f43dfb6472bc7d7422f2d'
  ENV['INSTAGRAM_CALLBACK'] = 'http://localhost:3000/oauth/instagram/callback'
  ENV["AWS_ACCESS_KEY_ID"] = 'AKIAIKZTOEKGDO6YLPEQ'
  ENV["AWS_SECRET_ACCESS_KEY"] = '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'
  ENV["AWS_S3_BUCKET"] = 'dev-feedfiction-images'
  ENV["AWS_S3_URL"] = "https://#{ENV["AWS_S3_BUCKET"]}.s3.amazonaws.com"
  ENV["ROOT_URL"] = "http://4qpc.localtunnel.com"
  
end
