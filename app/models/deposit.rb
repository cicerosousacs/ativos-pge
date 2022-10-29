class Deposit < ApplicationRecord
  belongs_to :ativo
  belongs_to :status

  #SCOPES
  scope :available, -> { where(status_id: 1) }
end
