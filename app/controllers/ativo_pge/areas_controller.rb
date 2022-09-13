class AtivoPge::AreasController < AtivosController
  before_action :set_area, only: [:edit, :update, :destroy]

  def index
    @areas = Area.all.page(params[:page])
    respond_to do |format|
      format.html
      format.json { render json: @areas }
    end
  end

  def new
    @area = Area.new
  end

  def create
    @area = Area.new(params_area)
    if @area.save()
      redirect_to ativo_pge_areas_path, notice: "Nova Área criada, Parabéns!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @area.update(params_area)
      redirect_to ativo_pge_areas_path, notice: "Área atualizada, Sucesso!"
    else
      render :edit
    end
  end

  def destroy
    if @area.destroy
      redirect_to ativo_pge_areas_path, notice: "Área excluida, Feito!"
    else
      render :index
    end
  end

  private

  def params_area
    params.require(:area).permit(:description)
  end

  def set_area
    @area = Area.find(params[:id])
  end
end
