require 'rest-client'
require 'json'

foreign_currencies = ['USD', 'JPY', 'GBP', 'HKD', 'CHF', 'CAD', 'SGD', 'AUD',
                      'BHD', 'KWD', 'SAR', 'BND', 'IDR', 'THB', 'AED', 'CNY',
                      'KRW', 'EUR']

foreign_currencies.each do |fc|

  URL = "http://rate-exchange.appspot.com/currency?from=" + fc + "&to=PHP"
  counts = Hash.new({value: 0})

  value = RestClient.get URL
  parsed = JSON.parse(value)

  SCHEDULER.every '2s', :first_in => 0 do |job|

    rate = parsed['rate'].round(2)

    #top advances
    advances = parsed.map{|fx| {:label => parsed['from'], :value => rate }}
    #  advances = stocks.top_changes.map{|stock| { :label => stock["name"],
                                                #:value => stock["percent_change"]}}
    send_event('advances', {items:  advances})
  end
end

