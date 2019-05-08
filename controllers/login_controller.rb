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
    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
    signup = Login.new
    signup.email = params[:email]
    signup.password_salt = password_salt
    signup.password_hash = password_hash
    signup.signup
    redirect "/"
  end



  get "/login" do
    @emails = Login.all
    email.id = params['id']
    email.email = params['email']
    email.password_hash = params['password_hash']
    email.password_salt = params['password_salt']
    erb :"login/index"
  end



end
