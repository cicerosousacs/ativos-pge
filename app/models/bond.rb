class Bond < ApplicationRecord
  belongs_to :subarea
  belongs_to :user

  has_many :attach_ativo, dependent: :destroy
  accepts_nested_attributes_for :attach_ativo, reject_if: :all_blank, allow_destroy: true

  has_many :call_number, dependent: :destroy
  accepts_nested_attributes_for :call_number, reject_if: :all_blank, allow_destroy: true

  before_save :update_deposit

  #VALIDAÇÔES
  validates :attach_ativo, presence: { message: "não informado!" }
  validates :call_number, presence: { message: "não informado!" }
  validates :user_id, uniqueness: true, unless: -> { user.id == 422 }
  
  #PAGINAÇÂO
  paginates_per 9

  PRESENTIAL = false
  HOMEOFFICE = true
  
  def update_deposit
    attach_ativo.each do |asset|
      id = asset.ativo_id
      status = asset.status_id
      note = asset.note
      deposit = Deposit.find_by_ativo_id(id)
      deposit.update_attributes(status_id: status, observation: note) 
    end
  end

  #N+1 e ordenação por ultimo criado
  def self.last_bond
    Bond.includes(:user, :subarea, :attach_ativo, :call_number).order("id desc")
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
