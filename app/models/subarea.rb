class Subarea < ApplicationRecord
  belongs_to :area

  paginates_per 10
end
