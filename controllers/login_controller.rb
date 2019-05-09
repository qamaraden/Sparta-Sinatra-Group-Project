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
    redirect "/signup"
  end

  get "/login" do
    @emails = Login.all
    erb :"login/index"
  end

  post "/login" do
    email = Login.all
    results = Login.find(params[:email])

    if params[:email] = results.email
      puts "Email exists in DB"
      if results.password_hash == BCrypt::Engine.hash_secret(params[:password], results.password_salt)
          puts "Password correct "
          session.clear
          session[params:email] = results.email
          puts session
          puts "sessions started for #{results.email}"
          redirect ('/home')
        else puts "Password incorrect"
      end
    else
      puts "No match - email doesn't exist in DB"
    end
  end

  get "/home" do

    erb :"login/home"

  end


  post "/logout" do
      session.clear
      redirect ('/login')

    end



end
