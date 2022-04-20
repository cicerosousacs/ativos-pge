class AtivoPge::WelcomeController < AtivosController

  def index

    @bonds = Bond.all.order("created_at DESC")
    @total_bonds = Bond.count(:id)

    #@ativos = Ativo.all
    @total_ativos = Ativo.count(:id)
    @type_count = Ativo.select(:type).group(:type).count

  end


end
