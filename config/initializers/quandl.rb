# # require 'quandl'
# Quandl::ApiConfig.api_key = 'akupyq38zWCZvjQhwLQH'
# Quandl::ApiConfig.api_version = '2015-04-09'

require 'quandl/client'

Quandl::Client.use 'http://quandl.com/api/'
Quandl::Client.token = 'akupyq38zWCZvjQhwLQH'