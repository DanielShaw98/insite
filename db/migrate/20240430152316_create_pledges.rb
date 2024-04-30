class CreatePledges < ActiveRecord::Migration[7.1]
  def change
    create_table :pledges do |t|
      t.text :content
      t.integer :votes
      t.references :user, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
