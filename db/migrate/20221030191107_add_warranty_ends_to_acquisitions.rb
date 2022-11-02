class AddWarrantyEndsToAcquisitions < ActiveRecord::Migration[5.2]
  def change
    add_column :acquisitions, :warranty_ends, :date
  end
end
