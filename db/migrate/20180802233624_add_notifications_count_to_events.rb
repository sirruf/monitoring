class AddNotificationsCountToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :notifications_count, :integer, default: 0
  end
end
