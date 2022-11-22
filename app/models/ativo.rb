class Ativo < ApplicationRecord
  # DESABILITA A COLUNA TYPE
  self.inheritance_column = :_type_disabled

  after_save :create_deposit

  # RELACIONAMENTOS
  belongs_to :acquisition
  has_one :user, through: :attach_ativo
  has_one :area, through: :attach_ativo
  has_one :subarea, through: :attach_ativo
  has_many :status
  has_many :bonds
  has_many :deposits

  # VALIDAÇÔES
  validates :type, :brand, :model, :serial, :tombo, presence: { message: 'não informado!' }
  # SCOPES
  scope :available_assets, -> { where(deposits: { status_id: 1 }) }
  scope :last_asset, -> { includes(:acquisition).order('id DESC') }
  # PAGINAÇÂO
  paginates_per 9

  def create_deposit
    Deposit.find_or_create_by(
      ativo_id: id,
      description: ativo_description,
      status_id: 1 # 1 = DISPONIVEL
    )
  end

  def ativo_description
    [type, brand, model].join(' ')
  end

  def self.pdf_ativo
    Ativo.includes(:acquisition, :attach_ativo).order(:tombo)
  end
end
