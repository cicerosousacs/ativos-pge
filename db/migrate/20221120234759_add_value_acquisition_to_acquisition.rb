class AddValueAcquisitionToAcquisition < ActiveRecord::Migration[5.2]
  def change
    add_column :acquisitions, :value_acquisition, :string
  end
end
