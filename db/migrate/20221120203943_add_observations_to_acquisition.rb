class AddObservationsToAcquisition < ActiveRecord::Migration[5.2]
  def change
    add_column :acquisitions, :observations, :string
  end
end
