class AddProfileToAdmin < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :profile, :integer
  end
end
