class User < ApplicationRecord
  paginates_per 10
  #has_many :ativos, through: :vinculo

  def check_has_many_bond
    { true => "Sim", false => "Não", nil => "Não" }.fetch(has_many_bond)
  end
end
