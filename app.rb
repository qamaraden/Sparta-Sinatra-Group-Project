require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/base'
require 'pg'
require 'bcrypt'
require_relative 'models/login.rb'
require_relative 'models/cohorts.rb'
require_relative 'models/roles.rb'
require_relative 'models/specs.rb'
require_relative 'models/users.rb'
require_relative 'controllers/login_controller.rb'
require_relative 'controllers/cohorts_controller.rb'
require_relative 'controllers/roles_controller.rb'
require_relative 'controllers/specs_controller.rb'
require_relative 'controllers/users_controller.rb'

class App < Sinatra::Base

  use Rack::MethodOverride
  use LoginController
  use CohortsController
  # use RolesController
  # use SpecsController
  use UsersController

  get '/' do

    erb :'login/index'
  end

end
