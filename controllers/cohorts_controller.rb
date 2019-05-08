class CohortsController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new {File.join(root, "views")}

  configure :development do
    register Sinatra::Reloader
  end

  get "/cohorts" do

    @title = "Cohorts"

    @cohorts = Cohorts.all

    erb :'cohorts/index'

  end

  get "/cohorts/new" do

    @cohort = Cohorts.new
    @specs = Spec.all

    erb :'cohorts/new'

  end

  get "/cohorts/:id" do

    id = params[:id].to_i

    @cohort = Cohorts.find(id)

    erb :'cohorts/show'

  end

  get "/cohorts/:id/edit" do

    id = params[:id].to_i

    @cohort = Cohorts.find(id)

    erb :'cohorts/edit'

  end

  post "/cohorts" do

    cohort = Cohorts.new

    cohort.cohortName = params[:cohortName]
    cohort.specId = Spec.get_id(params[:spec])

    cohort.save

    redirect "/cohorts"

  end

  put "cohorts/:id" do

    id = params[:id].to_i

    cohort = Cohorts.find(id)

    cohort.cohortName = params[:cohortName]
    cohort.specId = Spec.get_id(params[:spec])

    cohort.save

    redirect "/cohorts"

  end

  delete "cohorts/:id" do

    id = params[:id].to_i

    Cohorts.destroy(id)

    redirect "/cohorts"

  end

end
