class Area < ApplicationRecord
  has_many :subareas
  has_many :ativos, through: :bond

  paginates_per 10



end
