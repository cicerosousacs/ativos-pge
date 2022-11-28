class CreateAcquisitions < ActiveRecord::Migration[5.2]
  def change
    create_table :acquisitions do |t|
      t.string :item, null: false
      t.string :quantity, null: false
      t.string :manager, null: false
      t.date :acquisition_date, null: false
      t.string :contract_number, unique: true
      t.string :company, null: false
      t.string :interested_party, null: false
      t.integer :modality, null: false
      t.integer :source, null: false

      t.timestamps
    end
  end
end
