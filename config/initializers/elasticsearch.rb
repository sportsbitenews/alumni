require "faraday"
require "typhoeus/adapters/faraday"

host = ENV.fetch('SEARCHBOX_URL', '127.0.0.1:9200')

Searchkick.client = Elasticsearch::Client.new(
  hosts: [host], retry_on_failure: true)
