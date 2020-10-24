class ItemsController < ApplicationController

    get '/items' do
        if logged_in?
            @items = Item.all
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
            if params[:content] == ""
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

end