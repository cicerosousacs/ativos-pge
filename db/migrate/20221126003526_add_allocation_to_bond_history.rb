class AddAllocationToBondHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :bond_histories, :allocation_id, :integer
  end
end
