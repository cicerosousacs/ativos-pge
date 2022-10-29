class Bond < ApplicationRecord
  belongs_to :subarea
  belongs_to :user

  has_many :attach_ativo, dependent: :destroy
  accepts_nested_attributes_for :attach_ativo, reject_if: :all_blank, allow_destroy: true

  has_many :call_number, dependent: :destroy
  accepts_nested_attributes_for :call_number, reject_if: :all_blank, allow_destroy: true

  before_save :update_ativo_deposit

  #VALIDAÇÔES
  validates :attach_ativo, presence: { message: "não informado!" }
  validates :call_number, presence: { message: "não informado!" }
  validates :user_id, uniqueness: true, unless: -> { user.id == 422 }
  
  #PAGINAÇÂO
  paginates_per 9

  def update_ativo_deposit
    attach_ativo.each do |asset|
      # byebug
      as_id = asset.ativo_id
      as_status = asset.status.to_i
      as_note = asset.note
      as_is_linked = asset.status.to_i == 5 or asset.status.to_i == 6 ? true : false
      deposit = Deposit.find_by_ativo_id(as_id)
      deposit.update_attributes(linked: as_is_linked, status_id: as_status, observation: as_note) 
    end
  end

  #N+1 e ordenação por ultimo criado
  def self.last_bond
    Bond.includes(:user, :subarea, :attach_ativo).order("created_at DESC")
  end
  
  def bond_description
    if self.note.present? 
      [self.subarea.area.description, self.subarea.description, self.user.name, self.note].join(" - ")
    else
      [self.subarea.area.description, self.subarea.description, self.user.name].join(" - ")
    end
  end

  def check_home_office
    { true => "Homeoffice", false => "Presencial", nil => "Presencial" }.fetch(homeoffice)
  end
end
