class AddNoticeToBondHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :bond_histories, :notice, :string
  end
end
