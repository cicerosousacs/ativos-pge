class CreateCallNumbers < ActiveRecord::Migration[5.2]
  def change
    create_table :call_numbers do |t|
      t.references :bond, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
