class RolesController < Sinatra::Base

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

  get "/roles", :auth => true do
    @roles = Roles.all
    erb :'roles/index'

  end

get "/roles/new", :auth => true do

    role_id = Login.check_admin(session[:email])

    if (role_id == 1)
      @role = Roles.new

      erb :'roles/new'
    else
      redirect "/roles"
    end

  end

  get "/roles/:id", :auth => true do
    id = params[:id].to_i
    @role = Roles.find(id)
    erb :'roles/show'
  end

  get "/roles/:id/edit", :auth => true do

  role_id = params[:id].to_i
    user_role = Login.check_admin(session[:email])

    if(user_role == 1)
      @role = Roles.find(role_id)

      erb :'roles/edit'
    else
      redirect "/roles/#{role_id}"
    end

  end

  post "/roles/", :auth => true do
    role = Roles.new
    role.role_name = params[:role_name]
    role.save
    redirect "/roles"
  end

  put "/roles/:id", :auth => true do
    role_id = params[:id].to_i
    role = Roles.find(role_id)
    role.role_name = params[:role_name]
    role.save
    redirect "/roles"
  end

  delete "/roles/:id", :auth => true do
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
