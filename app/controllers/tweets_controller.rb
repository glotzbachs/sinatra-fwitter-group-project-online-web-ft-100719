class TweetsController < ApplicationController

        get '/tweets' do
            @tweets = Tweet.all
            erb :'/tweets/tweets_home'
        end

end
