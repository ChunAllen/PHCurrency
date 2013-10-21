require 'rest-client'
require 'json'

foreign_currencies = ['USD', 'JPY', 'GBP', 'HKD', 'CHF', 'CAD', 'SGD', 'AUD',
                      'BHD', 'KWD', 'SAR', 'BND', 'IDR', 'THB', 'AED', 'CNY',
                      'KRW', 'EUR']

URL = "http://rate-exchange.appspot.com/currency?from=USD&to=PHP"
#foreign_currencies.each do |fc|
  #URL = "http://rate-exchange.appspot.com/currency?from=" + fc + "&to=PHP"
  #value = RestClient.get URL
  #parsed << JSON.parse(value)
#end

SCHEDULER.every '2s', :first_in => 0 do |job|
  value = RestClient.get URL
  data = JSON.parse(value)
  #rate = parsed['rate'].round(2)

  puts data['from']
  puts data['rate']
  advances = {:label => '123', :value => '123'}
  send_event('advances', {items:  advances})
end


