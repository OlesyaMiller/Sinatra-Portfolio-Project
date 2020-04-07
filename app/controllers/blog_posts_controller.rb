class BlogPostsController < ApplicationController

    get '/blogposts' do 
        @blogposts = BlogPost.all 
        erb :'blog_posts/index'
    end

    get '/blogposts/new' do 
        erb :'blog_posts/new'
    end

    post '/blogposts' do
        if Helpers.is_logged_in?(session)
            blogpost = BlogPost.create(params)
            if blogpost.invalid?
                flash[:notice] = "Please make sure to fill out all the fields"
                redirect to '/blogposts/new'
            else
                user = Helpers.current_user(session)
                blogpost.user = user 
                blogpost.save 
                flash[:notice] = "You have just created a new blog post!" #####
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

    get '/blogposts/:id/edit' do 
        @blogpost = BlogPost.find_by_id(params["id"])
        if !Helpers.is_logged_in?(session) || !@blogpost || Helpers.current_user(session) != @blogpost.user 
            redirect to '/'
        end
        erb :'blog_posts/edit'
    end

    patch '/blogposts/:id' do 
        blogpost = BlogPost.find_by_id(params["id"])
        if blogpost && Helpers.current_user(session) == blogpost.user 
            blogpost.update(params["blogpost"])
            if blogpost.valid?
                redirect to "/blogposts/#{blogpost.id}"
            else
                redirect to "/blogposts/#{blogpost.id}/edit"
            end
        else
            redirect to '/blogposts'
        end
    end

    delete '/blogposts/:id/delete' do
        blogpost = BlogPost.find_by(id: params[:id])
        if blogpost && blogpost.user == Helpers.current_user(session)
            blogpost.destroy
        end
        redirect to '/blogposts'
    end
end