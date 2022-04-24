class CreateAttachAtivos < ActiveRecord::Migration[5.2]
  def change
    create_table :attach_ativos do |t|
      t.references :bond, foreign_key: true, null: false
      t.references :ativo, foreign_key: true, null: false
      t.string :description, null: false
      t.string :status, null: false
      t.string :note

      t.timestamps
    end
  end
end
