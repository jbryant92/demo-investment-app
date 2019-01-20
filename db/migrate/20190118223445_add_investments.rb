class AddInvestments < ActiveRecord::Migration[5.2]
  def change
    create_table :investments do |t|
      t.integer :campaign_id
      t.float :amount
      t.timestamps
    end
  end
end
