class AtivoPge::WelcomeController < AtivosController

  def index
    @bonds = Bond.includes(:user, :subarea).order("created_at DESC").limit(16)

    @total_bonds = Bond.count(:id)

    #@ativos = Ativo.all
    @total_ativos = Ativo.count(:id)

    #Agrupa ativo por tipo
    @type_count = Ativo.select(:type).group(:type).order("type ASC").count

    #Ativos disponiveis no deposito
    @ativos_available = Deposit.select{|d| d.status_id == 1}.count

    #Ativos vinculados sem/com usuário
    @ativos_linked = AttachAtivo.select{|at| at.status == '5'}.count
  end

  private

  def area_description
  end

end
