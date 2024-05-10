class RemovePurchaseCostFromPurchases < ActiveRecord::Migration[7.1]
  def change
    remove_column :purchases, :purchase_cost, :integer
  end
end
