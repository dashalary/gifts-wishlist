class CreateItemss < ActiveRecord::Migration

    def change
        create_table :items do |t|
            t.string :name
            t.integer :price
            t.string :store
            t.integer :user_id
        end
    end

end