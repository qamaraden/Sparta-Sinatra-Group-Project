class SpecsController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new {File.join(root, "views")}

  configure :development do
    register Sinatra::Reloader
  end

  get "/specs" do

    @specs = Specs.all

    erb :'specs/index'
  end

  get "/specs/new" do

    @spec = Specs.new

    erb :'specs/new'

  end

  get "/specs/:id" do

    id = params[:id].to_i

    @role = Specs.find(id)

    erb :'specs/show'

  end

  get "/specs/:id/edit" do

    spec_id = params[:id].to_i

    @spec = Specs.find(spec_id)

    erb :'specs/edit'

  end

  post "/specs/" do
    spec = Specs.new
    spec.spec_name = params[:spec_name]
    spec.save

    redirect "/specs"

  end

  put "/specs/:id" do

    spec_id = params[:id].to_i
    spec = Specs.find(spec_id)
    spec.spec_name = params[:role_name]
    spec.save

    redirect "/specs"

  end

  delete "/specs/:id" do

    spec_id = params[:id].to_i

    Specs.destroy(spec_id)

    redirect "/specs"

  end
end
