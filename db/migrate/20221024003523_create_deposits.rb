class CreateDeposits < ActiveRecord::Migration[5.2]
  def change
    create_table :deposits do |t|
      t.references :ativo, foreign_key: true
      t.string :descritpion
      t.references :status, foreign_key: true

      t.timestamps
    end
  end
end
