class AtivoPge::AtivosController < AtivosController
  before_action :set_ativo, only: [:edit, :update, :destroy]
  before_action :set_acquisition_selects, only: [:new, :create, :edit, :update]
  # desativa a proteção CSRF apenas para esse metodo
  protect_from_forgery except: :vincular_deposito

  def index
    @ativos = Ativo.all
    # FILTRA O ATIVO PELO ID
    if params[:id].present?
      @ativos = @ativos.where(id: params[:id])
    end
    respond_to do |format|
      format.html {
        if params[:search]
          @ativos = Ativo.last_ativo.search(params[:search]).page(params[:page])
        else
          @ativos = Ativo.ultimo_ativo(params[:page])
        end
      }
      format.pdf { @ativos = Ativo.pdf_ativo }
      format.json { render json: @ativos}
    end
    @type = Ativo.select(:type).group(:type) # CRIA UM SELECT DOS TIPOS DE ATIVOS
  end

  def new
    @ativo = Ativo.new
  end

  def create
    @ativo = Ativo.new(params_ativo)

    salvo = false
    Ativo.transaction do
      salvo = @ativo.save!
    end
    if salvo
      redirect_to ativo_pge_ativos_path, notice: "Ativo cadastrado e disponibilizado com sucesso!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ativo.update(params_ativo)
      redirect_to ativo_pge_ativos_path, notice: "Ativo atualizado. Sucesso!"
    else
      render :edit
    end
  end

  def destroy
    if @ativo.destroy
      redirect_to ativo_pge_ativos_path, notice: "Ativo excluido. Feito!"
    else
      render :index
    end
  end

  def vincular_deposito
    attach_ativos = params[:ativos_ids].split(',') 
    attach_ativos.each do |ativo|
      AttachAtivo.find_or_create_by!(
        bond_id:"1",
        ativo_id: ativo.to_i,
        description: ativo.to_i,
        status:"DISPONÍVEL"
      ) 
    end
    flash[:notice] = "Ativo(s) disponibilizado com Sucesso!"
    # respond_to do |format|
       # format.js { flash[:notice] = "Ativo(s) disponibilizado com Sucesso!" }
    # end
    
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

end
