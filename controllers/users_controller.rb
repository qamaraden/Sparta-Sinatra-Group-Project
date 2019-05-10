class UsersController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')

  set :views, Proc.new {File.join(root, "views")}

  configure :development do
    register Sinatra::Reloader
  end

  register do
    def auth (type)
      condition do
        redirect "/" unless session[:email]
      end
    end
  end

  get "/users", :auth => true do
    
    @users = Users.all
    erb :'users/index'
  end

  get "/users/new", :auth => true do

    @user = Users.new
    @cohorts = Cohorts.all
    @roles = Roles.all

    erb :'users/new'

  end

  get "/users/:id", :auth => true do

    user_id = params[:id].to_i
    @user = Users.find(user_id)

    erb :'users/show'

  end

  get "/users/:id/edit", :auth => true do

    user_id = params[:id].to_i
    @user = Users.find(user_id)
    @cohorts = Cohorts.all
    @roles = Roles.all

    erb :'users/edit'

  end

  post "/users/", :auth => true do

    user = Users.new

    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    user.email = params[:email]
    user.password_salt = password_salt
    user.password_hash = password_hash
    user.cohort_id = params[:cohort_id]
    user.role_id = params[:role_id]

    user.save

    redirect "/users"

  end

  put "/users/:id", :auth => true do

    user_id = params[:id].to_i

    user = Users.find(user_id)

    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    user.email = params[:email]
    user.password_salt = password_salt
    user.password_hash = password_hash
    user.cohort_id = params[:cohort_id]
    user.role_id = params[:role_id]

    user.save

    redirect "/users"

  end

  delete "/users/:id", :auth => true do

    user_id = params[:id].to_i

    Users.destroy(user_id)

    redirect "/users"

  end

end
