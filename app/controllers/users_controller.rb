class UsersController < ApplicationController

    # get '/users/'

    get '/signup' do
        if logged_in?
            redirect '/tweets'
        else
            erb :'/users/signup'
        end

    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            @success="no"
            erb :'/users/signup'
        else    
            @user=User.new(username: params[:username], email: params[:email], password: params[:password])
            redirect '/login'
        end
    end

    get '/login' do
        if logged_in?
            redirect '/tweets'
        else
            erb :'/users/login'
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])
	    if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect "/tweets"
		else
			redirect "/login"
        end
    end

    get "/logout" do
        session.clear
        redirect "/"
      end




end
