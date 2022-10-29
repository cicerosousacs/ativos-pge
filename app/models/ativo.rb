class Ativo < ApplicationRecord
  # DESABILITA A COLUNA TYPE
  self.inheritance_column = :_type_disabled

  # RELACIONAMENTOS
  belongs_to :acquisition
  belongs_to :status
  
  has_one :attach_ativo
  has_one :user, through: :attach_ativo
  has_one :area, through: :attach_ativo
  has_one :subarea, through: :attach_ativo

  has_many :bonds
  has_many :deposits
  
  # VALIDAÇÔES
  validates :type, :brand, :model, :serial, :tombo, presence: { message: "não informado!" }

  # PESQUISA DE ATIVOS
  # scope :search, -> (query) { 
  #   order(:created_at, :desc)
  #   text = "%#{query}%".upcase
  #   search_columns = %w[model tombo serial type brand]
  #   where(
  #     search_columns
  #     .map { |field| "#{field} LIKE :search" }
  #     .join(' OR '),
  #     search: text
  #     )
  #   }
  
  scope :available_assets, -> { where(deposits: {status_id: 1}) }  
  
  # PAGINAÇÂO
  paginates_per 9

  #descrição do ativo juntando tipo, marca e modelo
  def ativo_description
    [self.type, self.brand, self.model].join(" ")
  end

  # N+1 e ordaneção por ultimo criado
  scope :ultimo_ativo, -> (page) {
    Ativo.includes(:acquisition, :attach_ativo).order("created_at DESC").page(page)
  }

  def self.last_ativo
    Ativo.includes(:acquisition, :attach_ativo).order("created_at DESC") 
  end

  def self.pdf_ativo
    Ativo.includes(:acquisition, :attach_ativo).order(:tombo) 
  end


end