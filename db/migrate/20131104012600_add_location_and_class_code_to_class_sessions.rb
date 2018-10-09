class AddLocationAndClassCodeToClassSessions < ActiveRecord::Migration
  def change
    add_column :class_sessions, :location, :string
    add_column :class_sessions, :class_code, :string
  end
end
