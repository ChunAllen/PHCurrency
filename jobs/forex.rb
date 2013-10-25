require 'rest-client'
require 'json'

foreign_currencies = ['USD', 'JPY', 'GBP', 'HKD', 'CHF', 'CAD', 'SGD', 'AUD',
                      'BHD', 'KWD', 'SAR', 'BND', 'IDR', 'THB', 'AED', 'CNY',
                      'KRW', 'EUR']

forex = Array.new
#SCHEDULER.every '2s' do
  foreign_currencies.each do |fc|
    url = "http://rate-exchange.appspot.com/currency?from=" + fc + "&to=PHP"
    value = RestClient.get url
    parsed = JSON.parse(value)
    forex << parsed
  end
#end


  advances = forex.map{|fx| {:label => fx['from'], :value => fx['rate'].round(2) }}
  send_event('rates', {items:  advances})

