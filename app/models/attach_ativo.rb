class AttachAtivo < ApplicationRecord
  belongs_to :bond
  belongs_to :ativo

  #ENUM STATUS DO ATIVO
  enum status: { 
    DISPONÍVEL: 'DISPONÍVEL', 
    VÍNCULADO: 'VÍNCULADO', 
    "VÍNCULADO EM USO": 'VÍNCULADO EM USO', 
    DEFEITO: 'DEFEITO', 
    INSERVÍVEL: 'INSERVÍVEL', 
    "AGUARDANDO GARANTIA": 'AGUARDANDO GARANTIA' 
  }

end
