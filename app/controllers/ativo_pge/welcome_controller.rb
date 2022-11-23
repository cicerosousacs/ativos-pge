class AtivoPge::WelcomeController < AtivosController
  def index
    @bonds = Bond.includes(:user, :subarea).order('created_at DESC').limit(16)
    @total_bonds = Bond.count(:id)
    @total_ativos = Ativo.count(:id)
    @type_count = Ativo.select(:type).group(:type).order('type ASC').count
    @ativos_available = Deposit.select{ |d| d.status_id == 1 }.count
    @ativos_linked = AttachAtivo.select{ |at| at.status_id == 5 }.count
  end
end
