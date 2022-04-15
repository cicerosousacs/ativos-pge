class CreateAtivos < ActiveRecord::Migration[5.2]
  def change
    create_table :ativos do |t|
      t.string :type, null: false
      t.string :brand, null: false
      t.string :model, null: false
      t.string :serial, null: false
      t.string :tombo, null: false, unique: true
      t.text :specification
      t.references :acquisition, foreign_key: true

      t.timestamps
    end
  end
end
