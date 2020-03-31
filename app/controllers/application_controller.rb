class ApplicationController < Sinatra::Base 

    configure do
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "secret"
    end

    get '/home' do 
        erb :welcome #the welcome page is not rendering
        "Welcome!"
    end
end