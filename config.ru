require './config/environment'

use Rack::MethodOverride # so that the app knows how to handle PATCH, PUT, and DELETE requests!

use BlogPostsController
use UsersController
use CommentsController 
run ApplicationController