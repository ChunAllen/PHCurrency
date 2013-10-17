require 'twitter'

#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
Twitter.configure do |config|
  config.consumer_key = 'OofUMsxCiT8dvh49VSvQmA'
  config.consumer_secret = 'eq725PM1vI1hhYNOsUgUFsrCt4TnXI6UOr1hpRPpGo'
  config.oauth_token = '284385197-pmYyZiD74yHiJ85tZfWCmNHyxMTiolrs0q94M6au'
  config.oauth_token_secret = 'Z75dp5OtyG3LA83X09SGyLsv57Sozx7GO4Oi5ZzCLrA'
end

user = "BangkoSentral"

SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
    tweets = Twitter.user_timeline(user)

    if tweets
      tweets.map! do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
      end
      send_event('twitter_feeds', comments: tweets)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end