class DropCollaborations < ActiveRecord::Migration
  def up
    drop_table :collaborations
  end

  def down
    create_table :collaborations do |t|
      t.references :wiki
      t.references :user

      t.timestamps
    end
    add_index :collaborations, :wiki_id
    add_index :collaborations, :user_id
  end   
end
