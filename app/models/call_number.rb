class CallNumber < ApplicationRecord
  belongs_to :bond

  #VALIDAÇÔES
  validates :number, uniqueness: { message: "não pode ser o mesmo!" }
  validates :number, length: { is: 7 }
end
