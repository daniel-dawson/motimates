class AddStatusToConnections < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE TYPE connection_status AS ENUM ('pending', 'requested', 'accepted');
    SQL
    add_column :connections, :status, :connection_status
    add_index :connections, :status
  end

  def down
    remove_column :connections, :status
    execute <<-SQL
      DROP TYPE connection_status;
    SQL
  end
end
