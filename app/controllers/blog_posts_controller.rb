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

    post '/comments' do    
        comment = Comment.new(content: params["content"])
        blogpost = BlogPost.find_by_id(params["blog_post_id"])
        if comment && blogpost 
            user = Helpers.current_user(session)
            comment.user = user 
            comment.blog_post = blogpost 
            comment.save 
            redirect to "/blogposts/#{blogpost.id}"
        else
            redirect to '/'
        end
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
            redirect to "/blogposts/#{blogpost.id}"
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