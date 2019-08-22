class CreateConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :connections do |t|
      t.text :note
      t.references :users, index: true, foreign_key: true
      t.references :connected_user, index: true
      t.boolean :pending, default: true

      t.timestamps
    end

    add_foreign_key :connections, :users, column: :connected_user_id
    add_index :connections, [:user_id, :connected_user_id], unique: true
  end
end
