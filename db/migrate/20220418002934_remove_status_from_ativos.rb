class RemoveStatusFromAtivos < ActiveRecord::Migration[5.2]
  def change
    remove_column :ativos, :status, :string
  end
end
