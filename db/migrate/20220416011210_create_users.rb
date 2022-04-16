class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false, unique: true
      t.boolean :has_many_bond

      t.timestamps
    end
  end
end
