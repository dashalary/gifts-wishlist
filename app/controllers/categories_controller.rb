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

end