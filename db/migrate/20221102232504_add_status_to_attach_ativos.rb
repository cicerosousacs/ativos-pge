class AddStatusToAttachAtivos < ActiveRecord::Migration[5.2]
  def change
    add_reference :attach_ativos, :status, foreign_key: true
  end
end
