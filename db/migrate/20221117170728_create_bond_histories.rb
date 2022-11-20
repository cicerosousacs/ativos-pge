class CreateBondHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :bond_histories do |t|
      t.references :bond, foreign_key: true
      t.jsonb :received, default: '{}'
      t.jsonb :removed, default: '{}'

      t.timestamps
    end
  end
end
