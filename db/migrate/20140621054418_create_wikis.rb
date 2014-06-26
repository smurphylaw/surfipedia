class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title
      t.text :body
    end

    add_column :wikis do |t|
      t.boolean :public, default: true

      t.timestamps
    end
  end
end
