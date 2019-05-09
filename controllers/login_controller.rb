class LoginController < Sinatra::Base

  enable :sessions

  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new {File.join(root, "views")}
  configure :development do
    register Sinatra::Reloader
  end

  get "/signup" do
    @emails = Login.all
    erb :"login/signup"
  end

  post "/signup" do
    signup = Login.new
    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
    signup.email = params[:email]
    signup.password_salt = password_salt
    signup.password_hash = password_hash
    signup.save
    session[:email] = params[:email]
    redirect "/signup"
  end

  get "/" do
    @emails = Login.all
    erb :"login/index"
  end

  post "/users" do

    begin
      results = Login.find(params[:email])
      @email = results.email
      if params[:email] = results.email
        puts "Email exists in DB"
        if results.password_hash == BCrypt::Engine.hash_secret(params[:password], results.password_salt)
            puts "Password correct "
            session.clear
            session[:email] = params[:email]
            puts "sessions started for #{results.email}"
            puts session[:email]
            redirect "/users"
          else puts "Password incorrect"
        end
      end
      rescue IndexError
        'Error'
    end
  end

  get "/home" do
    if session[:email]
      erb :"login/home"
    else
      redirect "/login"
    end
  end

  post "/logout" do
    session.clear
    redirect "/"
  end

end
