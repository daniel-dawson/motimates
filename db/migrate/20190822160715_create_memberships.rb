class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :community_id
    end
    add_index :memberships, :user_id
    add_index :memberships, :community_id
  end
end
