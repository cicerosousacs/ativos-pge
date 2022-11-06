class Deposit < ApplicationRecord
  
  belongs_to :ativo
  belongs_to :status

  #SCOPES
  scope :available, -> { where(status_id: [1, 2, 3, 4]) } #Retorna quem estiver disponivel
  scope :available_at, -> { where(status_id: 1).count }
  scope :defect, -> { where(status_id: 2).count }
  scope :unusable, -> { where(status_id: 3).count }
  scope :awaiting_warranty, -> { where(status_id: 4).count }

  paginates_per 10

  def self.teste
    Deposit.includes(:ativo, :status)
  end
end
