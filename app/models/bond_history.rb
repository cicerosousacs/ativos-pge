class BondHistory < ApplicationRecord
  belongs_to :bond, optional: true
end
