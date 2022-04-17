class Bond < ApplicationRecord
  belongs_to :subarea
  belongs_to :user

  has_many :attach_ativo, dependent: :destroy
  accepts_nested_attributes_for :attach_ativo, reject_if: :all_blank, allow_destroy: true

  def bond_description
    #"#{area.descricao} - #{subarea.descricao} - #{usuario.nome}" 
    [self.subarea.area.description, self.subarea.description, self.user.name, self.note].join(" - ")
  end

  validates :attach_ativo, presence: { message: "É necessario incluir ao menos um Ativo!"}
  validates :user_id, uniqueness: true, unless: -> { user.has_many_bond == true }

end
