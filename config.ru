require './config/environment'

use Rack::MethodOverride
use BlogPostsController
use UsersController
run ApplicationController