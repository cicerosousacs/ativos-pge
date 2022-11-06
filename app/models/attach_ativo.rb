class AttachAtivo < ApplicationRecord
  belongs_to :bond
  belongs_to :ativo
  belongs_to :status

  #VALIDAÇÔES
  validates :ativo_id, uniqueness: { message: "não pode ser o mesmo!" }
  validates :status_id, presence: true
 
end
