class AddFreeAndPriceToVideos < ActiveRecord::Migration[7.1]
  def change
    add_column :videos, :free, :boolean
    add_column :videos, :price, :decimal, precision: 10, scale: 2
  end
end
