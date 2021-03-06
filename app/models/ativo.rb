class Ativo < ApplicationRecord
  # DESABILITA A COLUNA TYPE
  self.inheritance_column = :_type_disabled

  # RELACIONAMENTOS
  belongs_to :acquisition
  
  has_one :attach_ativo
  has_one :user, through: :attach_ativo
  has_one :area, through: :attach_ativo
  has_one :subarea, through: :attach_ativo

  has_many :bonds

  # PAGINAÇÂO
  paginates_per 10

  # VALIDAÇÔES
  validates :type, :brand, :model, :serial, :tombo, presence: true

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

  # PESQUISA DE ATIVOS
  scope :search, -> (query) { 
    order(:created_at, :desc)
    text = "%#{query}%".upcase
    search_columns = %w[model tombo serial type brand]
    where(
      search_columns
        .map { |field| "#{field} LIKE :search" }
        .join(' OR '),
      search: text
    )
  }

end