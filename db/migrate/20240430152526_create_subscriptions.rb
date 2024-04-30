class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.integer :subscription_cost
      t.string :subscription_status
      t.string :payment_details
      t.date :start_date
      t.date :end_date
      t.references :user, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
