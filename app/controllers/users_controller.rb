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
        @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
            if @user
                session[:user_id] = @user.id
                redirect '/items'
            else 
                redirect '/signup'
            end
    end

end