class Subarea < ApplicationRecord
  belongs_to :area
  has_many :ativos, through: :bond

  paginates_per 9

  def area_description
    self.area.description
  end
end
