class CategoriesController < ApplicationController

    get '/categories' do
        if logged_in?
            @categories = current_user.categories
            erb :'categories/categories'
        else
            redirect '/login'
        end
    end

    get '/categories/new' do
        if logged_in?
            @categories = Category.all
            erb :'categories/new'
        else
            redirect '/login'
        end
    end

    post '/categories' do
        if logged_in?
            if params[:name].blank?
              redirect '/categories/new'
            else
              @category = current_user.categories.build(name: params[:name])
              if @category.save
                redirect '/categories'
              else
                redirect '/categories/new'
              end
            end
        else
            redirect '/login'
        end
    end

    get '/categories/:id' do
        if logged_in?
          @category = current_user.categories.find_by(id: params[:id])
            # binding.pry
          if @category
        #    @items = current_user.items.select {|a| a.id} #my items in that category
            erb :'categories/show'
           else 
            # binding.pry
            redirect "/categories/#{@category.id}/items/new"
           end
        else        
          redirect '/login'
        end
    end

    get '/categories/:id/edit' do
        @category = current_user.categories.find_by_id(params[:id])
        if @category && logged_in?
        # if logged_in? && @category.user_id == current_user.id #this way user can only edit an item that he added
          erb :'categories/edit'
        elsif logged_in? && !@category         
          redirect '/categories'
        else          
          redirect '/login'
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

    delete '/categories/:id' do
        if logged_in?
            @category = current_user.categories.find_by_id(params[:id])  #looking inside user's collection
            if @category
                @category.destroy
            end
            redirect '/categories'
        else
            redirect '/login'
        end
    end

end