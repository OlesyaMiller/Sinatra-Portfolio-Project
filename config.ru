require './config/environment'

use Rack::MethodOverride
use BlogPostsController
use UsersController
use CommentsController 
run ApplicationController