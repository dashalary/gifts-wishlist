class UsersController < ApplicationController

    get "/" do
        erb :welcome
    end

    get '/signup' do
        if !logged_in?
        erb :'users/signup'
        else
        redirect '/items'
        end
    end

    post '/signup' do
        
        if params[:username].blank? || params[:email].blank? || params[:password].blank?
            redirect '/signup'
        else
            @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
            session[:user_id] = @user.id
            redirect '/items'
        end
    end

    
    get "/users/:slug" do
        User.find_by_slug(params[:username])
        erb :'users/show'
    end

end