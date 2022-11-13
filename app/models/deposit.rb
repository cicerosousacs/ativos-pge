class Deposit < ApplicationRecord
  
  belongs_to :ativo
  belongs_to :status

  #SCOPES
  scope :by_status, -> (status_id) { where(status_id: status_id) }
  scope :by_deposit, -> { where(status_id: [1, 2, 3, 4]) }
  scope :available, -> { where(status_id: 1) }
  scope :available_and_linked, -> { where(status_id: [1, 5, 6]) }
  scope :available_size, -> { where(status_id: 1).count }
  scope :defect_size, -> { where(status_id: 2).count }
  scope :unusable_size, -> { where(status_id: 3).count }
  scope :awaiting_warranty_size, -> { where(status_id: 4).count }

  paginates_per 9

  def self.asset_and_status
    Deposit.includes(:ativo, :status)
  end

  private

  def self.status_warehouse(status)
    if status.nil?
      Deposit.asset_and_status.by_deposit
    else
      Deposit.asset_and_status.by_status(status)
    end
  end
end
