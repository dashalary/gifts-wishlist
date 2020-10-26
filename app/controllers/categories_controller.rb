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
            # @categories = Category.all
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

    get '/categories/:id' do
        if logged_in?
          @category = current_user.categories.find_by_id(params[:id])
           if @category
           @items = current_user.items.select {|a| a.id} #my items in that category
            erb :'/categories/show'
           else 
            redirect '/categories/new'
           end
        else        
          redirect '/sessions/login'
        end
    end

    get '/categories/:id/edit' do
        @category = current_user.categories.find_by_id(params[:id])
        if logged_in? && @item.user_id == current_user.id #this way user can only edit an item that he added
          erb :'/categories/edit'
        elsif logged_in? && @item.user_id != current_user.id          
          redirect '/categories'
        else          
          redirect '/sessions/login'
        end
    end

    patch '/categories/:id' do
        @category = current_user.categories.find_by_id(params[:id])
            if logged_in? && !params[:name].blank?
                @category.update(name: params[:name])
                @category.save
                redirect "/categories/#{@category.id}"
            else
                redirect "/categories/#{@category.id}/edit"
            end
    end

    delete '/categories/:id/delete' do
        @category = current_user.categories.find_by_id(params[:id])
        if logged_in? && @item.user == current_user
            @category.destroy
            redirect '/categories'
        else
            redirect '/sessions/login'
        end
    end

end