class User < ApplicationRecord
  has_many :ativos, through: :bond
  belongs_to :bond, optional: true
  paginates_per 9

  validates :name, :email, presence: { message: 'não informado!' }

  def check_has_many_bond
    { true => 'Sim', false => 'Não', nil => 'Não' }.fetch(has_many_bond)
  end
end
