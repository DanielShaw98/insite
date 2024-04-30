class CreateCreators < ActiveRecord::Migration[7.1]
  def change
    create_table :creators do |t|
      t.text :bio
      t.string :specialisation
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
