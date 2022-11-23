class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :recoverable
  devise :database_authenticatable, :validatable, :rememberable, :registerable

  enum profile: %i[Padrão Admin]

  def check_active
    { true => 'Ativo', false => 'Inativo', nil => 'Inativo' }.fetch(active)
  end

  def active_for_authentication?
    super && active
  end
end
