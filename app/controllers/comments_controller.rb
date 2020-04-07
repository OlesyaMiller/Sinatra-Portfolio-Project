class CommentsController < ApplicationController

    post '/comments' do    
        comment = Comment.new(content: params["content"])
        blogpost = BlogPost.find_by_id(params["blog_post_id"])
        if comment.valid? && blogpost 
            user = Helpers.current_user(session)
            comment.user = user 
            comment.blog_post = blogpost 
            comment.save 
            flash[:notice] = "Your comment has been posted!"
            redirect to "/blogposts/#{blogpost.id}"
        else
            flash[:notice] = "Comment field can not be empty"
            redirect to "/blogposts/#{blogpost.id}"
        end
    end

    get '/comments/:id/edit' do 
        @comment = Comment.find_by_id(params["id"])
        if !Helpers.is_logged_in?(session) || !@comment || Helpers.current_user(session) != @comment.user 
            redirect to '/'
        end
        erb :'comments/edit'
    end

    patch '/comments/:id' do 
        comment = Comment.find_by_id(params["id"])
        blogpost = BlogPost.find_by_id(comment.blog_post_id)
        if comment && Helpers.current_user(session) == comment.user 
            comment.update(params["comment"])
            if comment.valid?
                redirect to "/blogposts/#{blogpost.id}"
            else
                flash[:notice] = "Comment field can not be empty"
                redirect to "/comments/#{comment.id}/edit"
            end
        end
    end

    delete '/comments/:id/delete' do
        comment = Comment.find_by(id: params[:id])
        if comment && comment.user == Helpers.current_user(session)
            comment.destroy
        end
        flash[:notice] = "You have successfully deleted the comment"
        redirect to "/blogposts/#{comment.blog_post_id}"
    end

end