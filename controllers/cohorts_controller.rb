class CohortsController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new {File.join(root, "views")}

  configure :development do
    register Sinatra::Reloader
  end

  register do
    def auth (email)
      condition do
        redirect '/' unless session[:email]
      end
    end
  end

  get "/cohorts", :auth => true do
      @title = "Cohorts"
      @cohorts = Cohorts.all
      erb :'cohorts/index'
  end

  get "/cohorts/new", :auth => true do
    set :foo, 'bar'
    role_id = Login.check_admin(session[:email])

    if (role_id == 1)
      @cohort = Cohorts.new
      @specs = Specs.all

      erb :'cohorts/new'
    else
      @title = "Cohorts"
      @cohorts = Cohorts.all

      erb :'cohorts/index'
    end

  end

  get "/cohorts/:id", :auth => true do

    id = params[:id].to_i

    @cohort = Cohorts.find(id)
    @users = Cohorts.find_users(id)

    erb :'cohorts/show'

  end

  get "/cohorts/:id/edit", :auth => true do

    id = params[:id].to_i

    @cohort = Cohorts.find(id)
    @specs = Specs.all


    erb :'cohorts/edit'

  end

  post "/cohorts/", :auth => true do

    cohort = Cohorts.new

    cohort.cohort_name = params[:cohort_name]
    cohort.spec_id = params[:spec_id]
    cohort.spec_name = params[:spec_name]


    cohort.save

    redirect "/cohorts"

  end

  put "/cohorts/:id", :auth => true do

    id = params[:id].to_i

    cohort = Cohorts.find(id)

    cohort.cohort_name = params[:cohort_name]
    cohort.spec_id = params[:spec_id]

    cohort.save

    redirect "/cohorts"

  end

  delete "/cohorts/:id", :auth => true do

    id = params[:id].to_i
    @check = Cohorts.check_id(id)

    if (@check == 0)
      Cohorts.destroy(id)

      redirect "/cohorts"
    else
      @error_message = "Error, Cohort in use."
      @cohort = Cohorts.find(id)
      @specs = Specs.all
      @users = Cohorts.find_users(id)
      erb :"cohorts/show"
    end

  end

end
