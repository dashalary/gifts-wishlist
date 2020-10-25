class ItemsController < ApplicationController

    get '/items' do
        if logged_in?
            @items = current_user.items.all
            erb :'items/items'
        else
            redirect '/sessions/login'
        end
    end

    get '/items/new' do
        if logged_in?
            erb :'items/new'
        else
            redirect '/sessions/login'
        end
    end

    post '/items' do
        if logged_in?
            if params[:name].blank?
              redirect '/items/new'
            else
              @item = current_user.items.build(name: params[:name], price: params[:price], store: params[:store])
              if @item.save
                redirect '/items'
              else
                redirect '/items/new'
              end
            end
        else
            redirect '/sessions/login'
        end
    end

    get '/items/:id' do
        if logged_in?
          @item = Item.find_by_id(params[:id])
          erb :'/items/show_item'
        else        
          redirect '/sessions/login'
        end
      end

      get '/items/:id/edit' do
        @item = Item.find_by_id(params[:id])
        if logged_in? && @item.user_id == current_user.id #this way user can only edit an item that he added
          erb :'/items/edit_item'
        elsif logged_in? && @item.user_id != current_user.id          
          redirect '/items'
        else          
          redirect '/sessions/login'
        end
      end

    patch '/items/:id' do
        @item = Item.find(params[:id])
            if logged_in? && !params[:name].blank?
                @item.update(name: params[:name], store: params[:store], price: params[:price])
                @item.save
                redirect "/items/#{@item.id}"
            else
                redirect "/items/#{@item.id}/edit"
            end
    end

    delete '/items/:id/delete' do
        @item = Item.find_by_id(params[:id])
        if logged_in? && @item.user == current_user
            @item.destroy
            redirect '/items'
        else
            redirect '/sessions/login'
        end
    end

end