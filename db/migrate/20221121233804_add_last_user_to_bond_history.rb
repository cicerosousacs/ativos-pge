class AddLastUserToBondHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :bond_histories, :last_user, :string
  end
end
