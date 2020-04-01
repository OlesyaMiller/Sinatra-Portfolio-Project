class UsersController < ApplicationController

    get '/signup' do        
        erb :'users/signup'
    end

    post '/signup' do 
        user = User.create(params)
        if user.valid?
            session[:user_id] = user.id
            redirect to "/users/#{user.id}"
        else
            redirect to '/signup'
        end
    end

    get '/users' do 
        @users = User.all 
        erb :'users/all'
    end

    get '/login' do
        erb :'users/login'
    end

    post '/login' do 
        user = User.find_by(username: params["username"])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to "/users/#{user.id}"
        else
            redirect to '/signup'
        end
    end

    get '/users/:id' do 
        if Helpers.is_logged_in?(session) && User.find_by_id(params["id"])
            @user = User.find_by_id(params["id"])
            @blogposts = @user.blog_posts
            erb :'users/show'
        else
            redirect to '/login'
        end
    end

    get '/logout' do 
        session.clear 
        redirect to '/'
    end
end