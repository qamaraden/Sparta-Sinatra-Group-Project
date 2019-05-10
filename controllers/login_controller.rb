class LoginController < Sinatra::Base

  enable :sessions

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

  post "/" do
    begin
      results = Login.find(params[:email])
      @email = results.email
      if params[:email] = results.email
        if results.password_hash == BCrypt::Engine.hash_secret(params[:password], results.password_salt)
          session.clear
          session[:email] = params[:email]
           session[:email]
          redirect "/users"
        else
          erb :"login/incorrect_password"
        end
      end
      rescue IndexError
        erb :"login/incorrect_details"
    end
  end

  post "/logout", :auth => :email do
    session.clear
    redirect "/"
  end

end
