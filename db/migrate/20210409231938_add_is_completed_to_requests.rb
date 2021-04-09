class AddIsCompletedToRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :requests, :is_completed, :boolean, default: false
  end
end
