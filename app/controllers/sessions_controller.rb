class SessionsController < ApplicationController

    get '/login' do
        if !logged_in?
            erb :'sessions/login'
        else
            redirect '/items'
        end
    end

    post '/login' do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect '/items'
        else
          redirect '/signup'
        end
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end


    helpers do
        def logged_in?
          !!session[:user_id]
        end
    
        def current_user
          User.find(session[:user_id])
        end
    
      end


end