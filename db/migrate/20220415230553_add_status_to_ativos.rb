class AddStatusToAtivos < ActiveRecord::Migration[5.2]
  def change
    add_column :ativos, :status, :string
  end
end
