class LoginController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new {File.join(root, "views")}

  configure :development do
    register Sinatra::Reloader
  end

  get "/signup" do
    erb :"login/signup"

  end

  post "/signup" do
    email = params[:email]

    signup = Login.new
    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
    signup.email = params[:email]
    email = params[:email]
    signup.password_salt = password_salt
    signup.password_hash = password_hash
  end

    get "/login" do
      @emails = Login.all
      erb :"login/index"
    end


  post "/login" do
    if userTable.has_key?(params[:username])
      user = userTable[params[:username]]
      if user[:passwordhash] == BCrypt::Engine.hash_secret(params[:password], user[:salt])
        session[:username] = params[:username]
        redirect "/"
      end
    end
    haml :error
  end


end
