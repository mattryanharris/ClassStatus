class AddExtraDataToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :extra_data, :string
  end
end
