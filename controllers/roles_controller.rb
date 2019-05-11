class RolesController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new {File.join(root, "views")}

  configure :development do
    register Sinatra::Reloader
  end

  get "/roles" do
    logged_in?
    @title = 'Sparta Global - Roles'
    @roles = Roles.all
    erb :'roles/index'
  end

  get "/roles/new" do
    logged_in?
    @title = 'Sparta Global - New Role'
    role_id = Login.check_admin(session[:email])

    if (role_id == 1)
      @role = Roles.new
      erb :'roles/new'
    else
      redirect "/roles"
    end
  end

  get "/roles/:id" do
    logged_in?
    id = params[:id].to_i
    @role = Roles.find(id)
    @title = "Sparta Global - #{@role.role_name}"
    erb :'roles/show'
  end

  get "/roles/:id/edit" do
    logged_in?
    @title = "Sparta Global - #{@role.role_name}"
    role_id = params[:id].to_i
    user_role = Login.check_admin(session[:email])

    if(user_role == 1)
      @role = Roles.find(role_id)
      @title = "Sparta Global - Edit #{@role.role_name}"
      erb :'roles/edit'
    else
      redirect "/roles/#{role_id}"
    end
  end

  post "/roles/" do
    logged_in?
    @title = 'Sparta Global - Role'
    role = Roles.new
    role.role_name = params[:role_name]
    role.save
    redirect "/roles"
  end

  put "/roles/:id" do
    logged_in?
    @title = 'Sparta Global - Role'
    role_id = params[:id].to_i
    role = Roles.find(role_id)
    role.role_name = params[:role_name]
    role.save
    redirect "/roles"
  end

  delete "/roles/:id" do
    logged_in?
    @title = 'Sparta Global - Role'
    id = params[:id].to_i
    role_id = Login.check_admin(session[:email])

    if (role_id == 1)
      @check = Roles.check_id(id)

      if (@check == 0)
        Roles.destroy(id)
        redirect "/roles"
      else
        @error_message = "Error, Role in use."
        @role = Roles.find(id)
        erb :"roles/show"
    end
    else
      redirect "/roles/#{id}"
    end
  end

end
