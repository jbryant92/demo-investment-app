class AddCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.string :name, :null => false
      t.text :image_url
      t.string :sector
      t.integer :country_id
      t.float :target_amount
      t.float :investment_multiple
      t.timestamps
    end
  end
end
