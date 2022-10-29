class AddActiveToAdmin < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :active, :boolean
  end
end
