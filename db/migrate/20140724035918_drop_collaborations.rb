class DropCollaborations < ActiveRecord::Migration
  def up
    drop_table :collaborations
    drop_table :wiki_collaborations
  end

  def down
    create_table :collaborations do |t|
      t.references :wiki
      t.references :user

      t.timestamps
    end

    create_table :wiki_collaborations do |t|
      t.referneces :plan
      t.references :user

      t.timestamps
    end

    add_index :collaborations, :plan_id
    add_index :collaborations, :user_id

    add_index :wiki_collaborations, :plan_id
    add_index :wiki_collaborations, :user_id
  end   
end