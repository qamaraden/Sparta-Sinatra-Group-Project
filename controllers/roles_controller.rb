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

  get "/roles", :auth => :email do

    @roles = Roles.all

    erb :'roles/index'

  end

  get "/roles/new", :auth => :email do

    @role = Roles.new

    erb :'roles/new'

  end

  get "/roles/:id", :auth => :email do

    id = params[:id].to_i
    @role = Roles.find(id)

    erb :'roles/show'

  end

  get "/roles/:id/edit", :auth => :email do

    role_id = params[:id].to_i
    @role = Roles.find(role_id)

    erb :'roles/edit'

  end
#
  post "/roles/", :auth => :email do

    role = Roles.new

    role.role_name = params[:role_name]

    role.save

    redirect "/roles"

  end

  put "/roles/:id", :auth => :email do

    role_id = params[:id].to_i

    role = Roles.find(role_id)


    role.role_name = params[:role_name]

    role.save

    redirect "/roles"

  end
#
  delete "/roles/:id", :auth => :email do

    role_id = params[:id].to_i

    Roles.destroy(role_id)

    redirect "/roles"

  end


end
