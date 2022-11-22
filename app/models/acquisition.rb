class Acquisition < ApplicationRecord
  has_many :ativos

  validates :item, :quantity, :value_acquisition, :manager, :acquisition_date,
            :modality, :contract_number, :source, :company, :interested_party,
            :warranty_ends, :warranty_period, presence: { message: 'não informado!' }

  enum modality: {
                  "COTAÇÃO PREÇO": 0,
                  PREGÃO: 1,
                  LEILÃO: 2,
                  CONCURSO: 3,
                  "DIÁLOGO COMPETITIVO": 4,
                  CONCORRÊNCIA: 5
                }

  enum source: {
                "PGE FUNDO": 0,
                MAPP: 1,
                FUNPECE: 2
              }
end
