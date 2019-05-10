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

    user_id = params[:id].to_i
    @user = Users.find(user_id)


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

    email = params[:email]

    @emails = Users.check_email(email)


    if (@emails == 0)
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

    else
      @error_message = "Error, Email in use."
      @user=Users.new
      @cohorts = Cohorts.all
      @roles = Roles.all
      erb :'users/new'
    end

  end

  put "/users/:id" do

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

  delete "/users/:id" do

    user_id = params[:id].to_i

    Users.destroy(user_id)

    redirect "/users"

  end

end
