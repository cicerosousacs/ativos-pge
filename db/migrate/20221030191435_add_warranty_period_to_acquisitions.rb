class AddWarrantyPeriodToAcquisitions < ActiveRecord::Migration[5.2]
  def change
    add_column :acquisitions, :warranty_period, :integer
  end
end
