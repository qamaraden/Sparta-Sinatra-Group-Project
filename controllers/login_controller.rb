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
    email = Login.new
    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
    signup.password_salt = password_salt
    signup.password_hash = password_hash
    signup.signup
    redirect "/"
  end



  get "/login" do
    @emails = Login.all
    erb :"login/index"
  end


end
