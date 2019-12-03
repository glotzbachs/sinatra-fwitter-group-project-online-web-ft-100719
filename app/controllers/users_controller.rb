class UsersController < ApplicationController

    # get '/users/:slug' do
    #     @user = User.find_by(slug: params[:slug])
    #     erb :'users/show'
    # end

    get '/signup' do
        if !logged_in?
            erb :'/users/signup'
        else
            redirect '/tweets'
        end
    end

    post '/signup' do
        if params[:username] != "" && params[:email] != "" && params[:password] != ""
            @user=User.new(params)
            @user.save
            session[:user_id]=@user.id
            redirect '/tweets'   
        else  
            redirect '/signup'
        end
    end

    get '/login' do
        if !logged_in?
            erb :'/users/login'
        else
            redirect '/tweets' 
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
	    if @user && @user.authenticate(password: params[:password])
			session[:user_id] = @user.id
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
