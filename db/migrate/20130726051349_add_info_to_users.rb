class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :sms_number, :string
    add_column :users, :sms_carrier, :string
		add_column :users, :roles, :string, array: true
  end
end
