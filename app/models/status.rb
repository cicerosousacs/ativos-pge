class Status < ApplicationRecord
  has_many :ativos
  has_many :attach_ativo

  belongs_to :deposit

  #SCOPES
  scope :linked_or_in_use, -> { where(id: [5, 6]) }
  scope :status_for_edition, -> { where(id: [1, 2, 5, 6])}
  scope :status_in_warehouse, -> { where(id: [1, 2, 3, 4]) }

  # def status_description
  #   [self.description]
  # end
end
