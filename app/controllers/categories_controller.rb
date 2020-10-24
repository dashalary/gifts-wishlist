class CategoriesController < ApplicationController

    get '/categories' do
        if logged_in?
            @categories = Category.all
            erb :'categories/categories'
        else
            redirect '/sessions/login'
        end
    end

    get '/categories/new' do
        if logged_in?
            erb :'categories/new'
        else
            redirect '/sessions/login'
        end
    end

    post '/categories' do
        if logged_in?
            if params[:name].blank?
              redirect '/categories/new'
            else
              @category = current_user.category.build(name: params[:name])
              if @category.save
                redirect '/categories'
              else
                redirect '/categories/new'
              end
            end
        else
            redirect '/sessions/login'
        end
    end

end