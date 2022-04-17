class CreateBonds < ActiveRecord::Migration[5.2]
  def change
    create_table :bonds do |t|
      t.references :subarea, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.string :note

      t.timestamps
    end
  end
end
