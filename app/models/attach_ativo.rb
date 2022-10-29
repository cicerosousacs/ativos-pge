class AttachAtivo < ApplicationRecord
  belongs_to :bond
  belongs_to :ativo

  #VALIDAÇÔES
  validates :ativo_id, uniqueness: { message: "não pode ser o mesmo!" }
  validates :status, presence: true
end
