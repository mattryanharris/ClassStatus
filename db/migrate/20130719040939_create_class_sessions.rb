class CreateClassSessions < ActiveRecord::Migration
  def change
    create_table :class_sessions do |t|
      t.string :name
      t.time :start_time
      t.time :end_time
      t.string :days

      t.timestamps
    end
  end
end
