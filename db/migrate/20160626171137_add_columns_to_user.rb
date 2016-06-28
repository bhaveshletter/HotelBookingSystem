class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :auth_token, :string, default: ''
    add_column :users, :contact_no, :string

    add_index :users, :auth_token, unique: true
  end
end
