class CategoriesController < ApplicationController

    get '/categories' do
        if logged_in?
            @categories = Category.all
            erb :'categories/categories'
        else
            redirect '/sessions/login'
        end
    end


end