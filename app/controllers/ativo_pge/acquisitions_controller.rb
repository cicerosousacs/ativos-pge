class AtivoPge::AcquisitionsController < AtivosController
  before_action :set_acquisition, only: %i[edit update destroy]

  def index
    @acquisitions = Acquisition.order('id desc')
  end

  def new
    @acquisition = Acquisition.new
  end

  def create
    @acquisition = Acquisition.new(params_acquisition)
    if @acquisition.save!
      redirect_to ativo_pge_acquisitions_path, notice: 'Aquisição cadastrado. Parabéns!'
    else
      render :new
    end
  end

  def show
    @acquisition = Acquisition.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def edit
  end

  def update
    if @acquisition.update(params_acquisition)
      redirect_to ativo_pge_acquisitions_path, notice: 'Aquisição atualizada. Parabéns!'
    else
      render :edit
    end
  end

  def destroy
    if @acquisition.destroy
      redirect_to ativo_pge_acquisitions_path, notice: 'Aquisição excluida. Parabéns!'
    else
      render :index
    end
  end

  private

  def params_acquisition
    params.require(:acquisition).permit(:item, :quantity, :value_acquisition, :manager, :acquisition_date,
                                        :modality, :contract_number, :source, :company, :interested_party,
                                        :warranty_ends, :warranty_period, :observations, :anexo_contrato, 
                                        :anexo_aditivo)
  end

  def set_acquisition
    @acquisition = Acquisition.find(params[:id])
  end
end
