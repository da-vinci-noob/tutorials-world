class AddApprovedToTutorials < ActiveRecord::Migration[6.1]
  def change
    add_column :tutorials, :is_approved, :boolean, default: false
  end
end
