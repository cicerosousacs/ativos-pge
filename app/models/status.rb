class Status < ApplicationRecord
  has_many :ativos

  #SCOPES
  scope :linked_or_in_use, -> { where(id: [5, 6]) }

  def status_description
    [self.description]
  end
end
