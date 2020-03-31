class BlogPostsController < ApplicationController

    get '/blogposts' do 
        @blogposts = BlogPost.all 
        erb :'blog_posts/all'
    end

    get '/blogposts/new' do 
        erb :'blog_posts/new'
    end

    post '/blogposts' do
        if Helpers.is_logged_in?(session)
            if params["content"] == "" || params["author_name"] == "" || params["title"] == ""
                redirect to '/blogposts/new'
            else
                blogpost = BlogPost.create(params)
                user = Helpers.current_user(session)
                blogpost.user = user 
                blogpost.save 
                redirect to "/blogposts/#{blogpost.id}"
            end
        else
            redirect to '/login'
        end
    end

    get '/blogposts/:id' do 
        @blogpost = BlogPost.find_by_id(params["id"])
        erb :'blog_posts/show'
    end
end