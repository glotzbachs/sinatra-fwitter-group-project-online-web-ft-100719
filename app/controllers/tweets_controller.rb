class TweetsController < ApplicationController

        get '/tweets' do
            if logged_in?
                @tweets = Tweet.all
                erb :'/tweets/tweets_index'
            else
                redirect '/login'
            end
        end

        get '/tweets/new' do
            if logged_in?
                erb :'/tweets/new'
            else
                redirect '/login'
            end
        end

        post '/tweets' do
           if logged_in?
                if params[:content] != ""
                    @tweet=Tweet.new(params)
                    @tweet.user=current_user
                    @tweet.save
                    redirect "/tweets/#{@tweet.id}" 
                else
                    redirect '/tweets/new'
                end
            else
                redirect '/login'
            end
        end

        get '/tweets/:id' do
            if logged_in?
                @tweet=Tweet.find_by_id(params[:id])
                erb :'/tweets/show'
            else
                redirect '/login'
            end
        end

        get '/tweets/:id/edit' do
            if logged_in?
                @tweet=Tweet.find_by_id(params[:id])
                if @tweet && @tweet.user==current_user
                    erb :'/tweets/edit'
                else
                    redirect '/tweets'
                end
            else
                redirect '/login'
            end
        end

        patch '/tweets/:id' do
            if logged_in?
                if params[:content] != ""
                    @tweet=Tweet.find_by_id(params[:id])
                    @tweet.update(content: params[:content])
                    redirect "/tweets/#{@tweet.id}" 
                else
                    redirect "/tweets/#{params[:id]}/edit" 
                end
            else
                redirect '/login'
            end
        end

        delete '/tweets/:id/delete' do
            if logged_in?
                @tweet = Tweet.find_by_id(params[:id])
                if @tweet && @tweet.user==current_user
                    @tweet.delete
                end
                redirect '/tweets'
            else
                redirect 'login'
            end
        end


end
