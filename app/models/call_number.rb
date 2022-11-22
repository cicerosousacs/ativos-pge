class CallNumber < ApplicationRecord
  belongs_to :bond

  #VALIDAÇÔES
  validates_uniqueness_of :number, scope: :bond_id, message: 'já foi informado!'
  validates :number, length: { is: 7 }
end
