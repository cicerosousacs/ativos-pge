class AddCallNumberToBond < ActiveRecord::Migration[5.2]
  def change
    add_column :bonds, :call_number, :integer
  end
end
