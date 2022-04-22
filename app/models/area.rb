class Area < ApplicationRecord
  has_many :subareas
  has_many :ativos, through: :attach_ativo
 

  paginates_per 10



end
