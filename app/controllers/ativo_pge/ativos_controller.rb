class AtivoPge::AtivosController < AtivosController
  before_action :set_ativo, only: %i[edit update destroy]
  before_action :set_acquisition_selects, only: %i[new create edit update]
  # desativa a proteção CSRF apenas para esse metodo
  protect_from_forgery except: :link_to_deposit

  def index
    @q = Ativo.ransack(params[:q])
    @ativos = @q.result.last_asset.page(params[:page])
    @total_ativos = Ativo.count(:id)

    if params[:id].present?
      @ativos = @ativos.where(id: params[:id])
    end
    respond_to do |format|
      format.html
      format.pdf { @ativos = Ativo.pdf_ativo }
      format.json { render json: @ativos}
    end
  end

  def new
    @ativo = Ativo.new
  end

  def create
    @ativo = Ativo.new(params_ativo)
    if @ativo.save
      redirect_to ativo_pge_ativos_path, notice: 'Ativo cadastrado e enviado ao depósito com sucesso!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ativo.update(params_ativo)
      redirect_to ativo_pge_ativos_path, notice: 'Ativo atualizado. Sucesso!'
    else
      render :edit
    end
  end

  def destroy
    if @ativo.destroy
      redirect_to ativo_pge_ativos_path, notice: 'Ativo excluido. Feito!'
    else
      render :index
    end
  end

  def link_to_deposit
    assets = params[:asset_ids].split(',')
    qtd_asset = assets.length
    text_asset = assets.length > 1 ? 'Ativos diponibilizados' : 'Ativo diponibilizado'
    assets.each do |a|
      Deposit.find_or_create_by!(
        ativo_id: a.to_i,
        description: description_active(a.to_i),
        status_id: 1 # 1 = DISPONIVEL
      )
      flash[:notice] = "#{qtd_asset} - #{text_asset} com sucesso!"
      # redirect_to '/ativo_pge/ativos'
    end
  end

  def gerar_pdf_ativo
  end

  private

  def params_ativo
    params.require(:ativo).permit(:type, :brand, :model, :tombo, :serial, :specification, :acquisition_id)
  end

  def set_ativo
    @ativo = Ativo.find(params[:id])
  end

  def set_acquisition_selects
    @acquisition_selects = Acquisition.pluck(:contract_number, :id)
  end

  def description_active(id)
    active = Ativo.find(id)
    [active.type, active.brand, active.model].join(' ')
  end
end
