class Bond < ApplicationRecord
  belongs_to :subarea
  belongs_to :user

  has_many :attach_ativo, dependent: :destroy
  accepts_nested_attributes_for :attach_ativo, reject_if: :all_blank, allow_destroy: true

  validates :attach_ativo, presence: { message: "É necessario incluir ao menos um Ativo!"}
  validates :user_id, uniqueness: true, unless: -> { user.has_many_bond == true }
  
  def self.last_bond
    # N+1 e ordaneção por ultimo criado
    Bond.includes(:user, :subarea, :attach_ativo).order("created_at DESC")
  end
  
  def bond_description
    #"#{area.descricao} - #{subarea.descricao} - #{usuario.nome}" 
    [self.subarea.area.description, self.subarea.description, self.user.name].join(" - ")
  end

  def check_home_office
    { true => "Homeoffice", false => "Presencial", nil => "Presencial" }.fetch(homeoffice)
  end

end
