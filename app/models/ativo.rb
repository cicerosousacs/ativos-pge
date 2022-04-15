class Ativo < ApplicationRecord
  # DESABILITA A COLUNA TYPE
  self.inheritance_column = :_type_disabled

  # RELACIONAMENTOS
  belongs_to :acquisition

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
    includes(:acquisition).order("created_at DESC").page(page)
  }

  def self.last_ativo
    Ativo.includes(:acquisition).order("created_at DESC") 
  end

  # PESQUISA DE ATIVOS
  scope :search, -> (query) { 
    text = "%#{query}%"
    search_columns = %w[model tombo serial type brand]
    where(
      search_columns
        .map { |field| "#{field} LIKE :search" }
        .join(' OR '),
      search: text
    )
  }


end
