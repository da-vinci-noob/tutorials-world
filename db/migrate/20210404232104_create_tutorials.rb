class CreateTutorials < ActiveRecord::Migration[6.1]
  def change
    create_table :tutorials do |t|
      t.string :title
      t.text :body
      t.references :language

      t.timestamps
    end
  end
end
