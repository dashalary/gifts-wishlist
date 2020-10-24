class CreateItems < ActiveRecord::Migration

    def change
        create_table :items do |t|
            t.string :name
            t.string :store
            t.integer :price
            t.integer :user_id
            t.integer :category_id
        end
    end
end