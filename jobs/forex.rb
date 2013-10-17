require 'rest-client'
require 'json'

URL = "http://rate-exchange.appspot.com/currency?from=JPY&to=PHP"

SCHEDULER.every '2s', :first_in => 0 do |job|
  value = RestClient.get URL
  data = JSON.parse(value)

  #values
  #values = stocks.value(settings.stock_symbol)

  #top advances
  advances = data.map{|forx| { :label => forx["from"],
                                              :value => forx["rate"]}}

  #send_event('stock', {current: values[:current], last: values[:previous]})
  #send_event('stock-volume', {value: stocks.find(settings.stock_symbol)["volume"],
                              #max: stocks.total_volume})
  send_event('advances', {items: advances})
end

