class AddLinkedToDeposit < ActiveRecord::Migration[5.2]
  def change
    add_column :deposits, :linked, :boolean
  end
end
