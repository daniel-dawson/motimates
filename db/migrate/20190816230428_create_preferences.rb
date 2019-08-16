class CreatePreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :preferences do |t|
      t.integer :min_age
      t.integer :max_age
      t.string :gender

      t.timestamps
    end
  end
end
