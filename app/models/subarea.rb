class Subarea < ApplicationRecord
  belongs_to :area
  has_many :ativos, through: :bond

  paginates_per 9

  validates :description, presence: { message: 'não informado!' }
  validates_uniqueness_of :description, scope: :area_id, message: 'informada já existe na Área selecionada.'

  def area_description
    self.area.description
  end
end
