class Ativo < ApplicationRecord
  # DESABILITA A COLUNA TYPE
  self.inheritance_column = :type_disabled

  after_save :send_to_deposit

  ransack_alias :asset, :model_or_tombo_or_serial_or_type_or_brand

  belongs_to :acquisition
  has_one :user, through: :attach_ativo
  has_one :area, through: :attach_ativo
  has_one :subarea, through: :attach_ativo
  has_many :status
  has_many :bonds
  has_many :deposits

  # VALIDAÇÔES
  validates :type, :brand, :model, :serial, :tombo, presence: { message: 'não informado!' }
  # SCOPES
  scope :available_assets, -> { where(deposits: { status_id: 1 }) }
  scope :last_asset, -> { includes(:acquisition).order('type asc') }
  # PAGINAÇÂO
  paginates_per 10

  enum type: {
                CAMERA: 'CAMERA',
                DESKTOP: 'DESKTOP',
                ESTABILIZADOR: 'ESTABILIZADOR',
                EXTENSÃO: 'EXTENSÃO',
                "FALTA O TIPO": 'FALTA O TIPO',
                "HD EXTERNO": 'HD EXTERNO',
                HUB: 'HUB',
                IMPRESSORA: 'IMPRESSORA',
                "IMPRESSORA TÉRMICA": 'IMPRESSORA TÉRMICA',
                "LEITOR BIOMÉTRICO": 'LEITOR BIOMÉTRICO',
                "LEITOR COD. BARRAS": 'LEITOR COD. BARRAS',
                "MODULO ISOLADOR": 'MODULO ISOLADOR',
                MONITOR: 'MONITOR',
                MOUSE: 'MOUSE',
                NOBREAK: 'NOBREAK',
                NOTEBOOK: 'NOTEBOOK',
                PEDESTAL: 'PEDESTAL',
                PLOTTER: 'PLOTTER',
                PROJETOR: 'PROJETOR',
                SCANNER: 'SCANNER',
                SWITCH: 'SWITCH',
                TABLET: 'TABLET',
                TECLADO: 'TECLADO',
                TOKEN: 'TOKEN',
                TV: 'TV',
                VOIP: 'VOIP',
                WEBCAM: 'WEBCAM'
              }

  def send_to_deposit
    if asset_is_present
      Deposit.create!(
        ativo_id: id,
        description: ativo_description,
        status_id: 1 # 1 = DISPONIVEL
      )
    end
  end

  def ativo_description
    [type, brand, model].join(' ')
  end

  def self.pdf_ativo
    Ativo.includes(:acquisition, :attach_ativo).order(:tombo)
  end

  def asset_is_present
    present = Deposit.find_by_ativo_id(id).present?
    !present
  end
end
