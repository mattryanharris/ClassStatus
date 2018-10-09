class CreateClassSessionSubscribers < ActiveRecord::Migration
  def change
    create_table :class_sessions_subscribers, id: false do |t|
      t.references :class_session, index: true
      t.references :subscriber, index: true
    end
  end
end
