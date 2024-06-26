class CreateAvatars < ActiveRecord::Migration[7.1]
  def change
    create_table :avatars do |t|
      t.string :image_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
