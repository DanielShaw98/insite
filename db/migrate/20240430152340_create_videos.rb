class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.text :requirements
      t.text :learning
      t.text :audience
      t.text :includes
      t.string :external_video_url
      t.string :accessibility
      t.integer :views
      t.float :average_rating
      t.string :thumbnail_url
      t.references :creator, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
