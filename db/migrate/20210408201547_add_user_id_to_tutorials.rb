class AddUserIdToTutorials < ActiveRecord::Migration[6.1]
  def change
    add_reference :tutorials, :user, null: false, foreign_key: true
  end
end
