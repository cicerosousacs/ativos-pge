class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def check_active
    { true => "Ativo", false => "Inativo", nil => "Inativo" }.fetch(active)
  end
end
