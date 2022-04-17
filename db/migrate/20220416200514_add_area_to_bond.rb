class AddAreaToBond < ActiveRecord::Migration[5.2]
  def change
    add_column :bonds, :area, :string, null: false
  end
end
