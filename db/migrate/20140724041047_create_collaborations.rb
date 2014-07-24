class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.references :user
      t.references :wiki, index: true

      t.timestamps
    end
  end
end
