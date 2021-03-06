Geocoder.configure(

  # geocoding service (see below for supported options):
  :lookup => :google,

  # IP address geocoding service (see below for supported options):
  :ip_lookup => :ipinfo_io,

  # to use an API key:
  #:api_key => "...",

  # geocoding service request timeout, in seconds (default 3):
  :timeout => 15,

  # set default units to kilometers:
  #:units => :km,

  # caching (see below for details):
  #:cache => Redis.new,
  #:cache_prefix => "..."

)