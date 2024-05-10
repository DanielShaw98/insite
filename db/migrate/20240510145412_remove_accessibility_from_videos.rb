class RemoveAccessibilityFromVideos < ActiveRecord::Migration[7.1]
  def change
    remove_column :videos, :accessibility, :string
  end
end
