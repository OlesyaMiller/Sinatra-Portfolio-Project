class ApplicationController < Sinatra::Base 

    configure do
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "secret"
    end

    get '/' do 
        erb :welcome 
    end

end