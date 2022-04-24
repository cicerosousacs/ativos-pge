class AtivoPge::WelcomeController < AtivosController

  def index

    @bonds = Bond.includes(:user, :subarea).order("created_at DESC").limit(10)
    @total_bonds = Bond.count(:id)

    #@ativos = Ativo.all
    @total_ativos = Ativo.count(:id)
    @type_count = Ativo.select(:type).group(:type).count

    @ativos_available = AttachAtivo.DISPONÍVEL.count
    @ativos_linked = AttachAtivo.VÍNCULADO.count

  end

  private

  def area_description
  end

end
