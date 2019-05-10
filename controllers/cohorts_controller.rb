class CohortsController < Sinatra::Base




  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new {File.join(root, "views")}

  configure :development do
    register Sinatra::Reloader
  end


  register do
    def auth (type)
      condition do
        redirect '/' unless session[:email]
      end
    end
  end

  get "/cohorts", :auth => :email do
      @title = "Cohorts"
      @cohorts = Cohorts.all
      erb :'cohorts/index'

  end

  get "/cohorts/new", :auth => :email do

    @cohort = Cohorts.new
    @specs = Specs.all



    erb :'cohorts/new'

  end

  get "/cohorts/:id", :auth => :email do

    id = params[:id].to_i

    @cohort = Cohorts.find(id)
    @users = Cohorts.find_users(id)

    erb :'cohorts/show'

  end

  get "/cohorts/:id/edit", :auth => :email do

    id = params[:id].to_i

    @cohort = Cohorts.find(id)
    @specs = Specs.all


    erb :'cohorts/edit'

  end

  post "/cohorts/", :auth => :email do

    cohort = Cohorts.new

    cohort.cohort_name = params[:cohort_name]
    cohort.spec_id = params[:spec_id]
    cohort.spec_name = params[:spec_name]


    cohort.save

    redirect "/cohorts"

  end

  put "/cohorts/:id", :auth => :email do

    id = params[:id].to_i

    cohort = Cohorts.find(id)

    cohort.cohort_name = params[:cohort_name]
    cohort.spec_id = params[:spec_id]

    cohort.save

    redirect "/cohorts"

  end

  delete "/cohorts/:id", :auth => :email do

    id = params[:id].to_i

    Cohorts.destroy(id)

    redirect "/cohorts"

  end

end
