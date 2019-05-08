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
    @cohorts = Cohorts.all
    @roles = Roles.all

    erb :'users/show'

  end

  get "/users/:id/edit" do

    id = params[:id].to_i
    @user = Users.find(id)

    erb :'users/edit'

  end

  post "/users" do

    user = Users.new
    user.firstName = params[:firstName]
    user.lastName = params[:lastName]
    user.email = params[:email]
    user.password = params[:password]
    user.cohortId = Cohorts.get_id(params[:cohortName])
    user.roleId = Role.get_id(params[:roleName])

    user.save

    redirect "/users"

  end

  put "/users/:id" do

    id = params[:id].to_i
    user = Users.find(id)
    user.firstName = params[:firstName]
    user.lastName = params[:lastName]
    user.email = params[:email]
    user.password = params[:password]
    user.cohortId = Cohorts.get_id(params[:cohortName])
    user.roleId = Role.get_id(params[:roleName])

    user.save

    redirect "/users"

  end

  delete "/users/:id" do

    id = params[:id].to_i

    Users.destroy(id)

    redirect "users/"

  end

end
