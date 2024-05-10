class RenameSubscriptionsToFollowingsAndRemoveColumns < ActiveRecord::Migration[7.1]
  def change
    rename_table :subscriptions, :followings
    remove_column :followings, :subscription_cost
    remove_column :followings, :subscription_status
    remove_column :followings, :payment_details
    remove_column :followings, :start_date
    remove_column :followings, :end_date
  end
end
