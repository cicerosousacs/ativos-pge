class Bond < ApplicationRecord
  before_save :update_deposit
  before_save :bond_update_history
  after_save :bond_creation_history

  belongs_to :subarea
  belongs_to :user

  has_one :bond_histories

  has_many :attach_ativo, dependent: :destroy
  accepts_nested_attributes_for :attach_ativo, reject_if: :all_blank, allow_destroy: true

  has_many :call_number, dependent: :destroy
  accepts_nested_attributes_for :call_number, reject_if: :all_blank, allow_destroy: true

  validates :attach_ativo, presence: { message: 'não informado!' }
  # validates :call_number, presence: { message: "não informado!" }
  validates :user_id, uniqueness: true, unless: -> { user.id == 422 }

  paginates_per 9

  # scope :linked_assets, -> { joins(:attach_ativo).where(created_at: Date.today.all_day) }

  def self.last_bond
    Bond.includes(:user, :subarea, :attach_ativo, :call_number).order('id desc')
  end

  def bond_description
    if note.present?
      [subarea.area.description, subarea.description, user.name, note].join(' - ')
    else
      [subarea.area.description, subarea.description, user.name].join(' - ')
    end
  end

  def check_home_office
    { true => 'Homeoffice', false => 'Presencial', nil => 'Presencial' }.fetch(homeoffice)
  end

  private

  def update_deposit
    attach_ativo.each do |asset|
      id = asset.ativo_id
      status = asset.status_id
      note = asset.note
      deposit = Deposit.find_by_ativo_id(id)
      deposit.update_attributes(status_id: status, observation: note)
    end
  end

  def bond_creation_history
    if BondHistory.find_by_bond_id(bond_id).nil?
      history = BondHistory.new(
        {
          bond_id: bond_id,
          received: received_asset
        }
      )
      history.save!
      send_email_creation_bond
    end
  end

  def bond_update_history
    history = BondHistory.new(
      {
        bond_id: bond_id,
        received: attach_ativo.select { |rec| rec.created_at.blank? },
        removed: attach_ativo.select { |rem| rem.status_id == 2 }
      }
    )
    history.save!
    send_email_update_bond
  end

  def send_email_creation_bond
    creation_date = created_at.to_json
    SendEmail.create_bond(user_name, user_email, creation_date, received_asset).deliver_later
  end

  def send_email_update_bond
    bond = BondHistory.where(bond_id: id).last
    creation_date = bond.created_at.to_json
    received = bond.received
    removed = bond.removed
    SendEmail.update_bond(user_name, user_email, creation_date, received, removed).deliver_later
  end

  def user_name
    User.find_by_id(user_id).name
  end

  def user_email
    User.find_by_id(user_id).email
  end

  def bond_id
    attach_ativo.first.bond.id
  end

  def received_asset
    attach_ativo.select { |rec| rec.status_id == 6 }
  end
end
