require "sinatra"

class CookieApp < Sinatra::Base
  enable :sessions

  def initialize
    super
    @users = [
      {
        id: 1,
        name: "Hunter",
        email: "hunter@galvanize.it"

      },
      {
        id: 2,
        name: "Jeff",
        email: "taggart@galvanize.it"
      }
    ]
  end

  get "/" do
    user = current_user
    erb :home, locals: {user: user}
  end

  get "/sign_in" do
    erb :sign_in, locals: {user: current_user}
  end

  post "/sign_in" do
    user = find_user(params[:name])
    session[:user_id] = user[:id]
    erb :home, locals: {user: user}
  end

  get "/sign_out" do
    session[:user_id] = nil
    erb :home, locals: {user: current_user}
  end

  def current_user
    @users.select { |user| user[:id] == session[:user_id].to_i }.first
  end

  def find_user(name)
    @users.select {|user| user[:name] == name }.first
  end
end
