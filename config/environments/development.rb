Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false 

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Generate errors if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  # Change email delivery to :smtp, :sendmail, :file, :test
  config.action_mailer.delivery_method = :letter_opener

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # needed for devise mailer
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

 # Amazon Web Services - S
  config.paperclip_defaults = {
    :storage => :s3,
    :s3_credentials => {
      :bucket => 'pampered-dev',
      :s3_credentials => "/config/aws.yml",
    }
  } 


  class ActionDispatch::Request

    def remote_ip
      # "71.194.131.16" # seths chicago house
        "24.25.214.8" # seths carlsbad house
      # "71.212.123.5" # ipd home (Denver,CO or Renton,WA)                                                                                                                                                                                                                                                                        
      # "208.87.35.103" # websiteuk.com -- Nassau, Bahamas                                                                                                                                                                                                                                                                      
      # "50.78.167.161" # HOL Seattle, WA                                                                                                                                                                                                                                                                                       
    end

  end

end
