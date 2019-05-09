class UsersController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')

  set :views, Proc.new {File.join(root, "views")}

  configure :development do
    register Sinatra::Reloader
  end

  get "/users" do

    @users = Users.all

    erb :'users/index'
  end

  get "/users/new" do

    @user = Users.new
    @cohorts = Cohorts.all
    @roles = Roles.all

    erb :'users/new'

  end

  get "/users/:id" do

    id = params[:id].to_i
    @user = Users.find(id)
    @cohorts = Cohorts.find(@user.cohortId)
    @roles = Roles.find(@user.rolesId)

    erb :'users/show'

  end

  get "/users/:id/edit" do

    user_id = params[:id].to_i
    @user = Users.find(user_id)
    @cohorts = Cohorts.all
    @roles = Roles.all

    erb :'users/edit'

  end

  post "/users/" do

    user = Users.new


    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    user.email = params[:email]
    user.password = params[:password]
    user.cohort_id = params[:cohort_id]
    user.role_id = params[:role_id]

    user.save

    redirect "/users"

  end

  put "/users/:id" do

    user_id = params[:id].to_i

    user = Users.find(user_id)

    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    user.email = params[:email]
    user.password = params[:password]
    user.cohort_id = params[:cohort_id]
    user.role_id = params[:role_id]

    user.save

    redirect "/users"

  end

  delete "/users/:id" do

    user_id = params[:id].to_i

    Users.destroy(user_id)

    redirect "/users"

  end

end
