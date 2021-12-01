require 'typhoeus/cache/rails'

Ethon.logger = Logger.new('log/http_requests.log')
Typhoeus::Config.cache = Typhoeus::Cache::Rails.new
