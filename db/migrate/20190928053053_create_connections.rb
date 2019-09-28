class CreateConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :connections do |t|
      t.text :note
      t.integer :user_id
      t.integer :motimate_id

      t.datetime :accepted_at
      t.timestamps
    end
  end
end
