class RemoveLinkedToDeposit < ActiveRecord::Migration[5.2]
  def change
    remove_column :deposits, :linked, :boolean
  end
end
