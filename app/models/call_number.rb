class CallNumber < ApplicationRecord
  belongs_to :bond

  #VALIDAÇÔES
  validates :number, uniqueness: { message: "já foi informado!" }
  validates :number, length: { is: 7 }
end
