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

  get "/" do
    erb :"partials/login-form"
  end

  post "/" do
    puts Login.check_admin(params[:email])
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

  post "/logout", :auth => true do
    session.clear
    redirect "/"
  end

end
