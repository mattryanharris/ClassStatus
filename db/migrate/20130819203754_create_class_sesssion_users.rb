class CreateClassSesssionUsers < ActiveRecord::Migration
  def change
    create_table :class_sessions_users, id: false do |t|
      t.references :class_session, index: true
      t.references :user, index: true
    end
  end
end
