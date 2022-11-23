class AtivoPge::SubareasController < AtivosController
  before_action :set_subarea, only: %i[edit update destroy]
  before_action :set_area_options, only: %i[new create edit update]

  def index
    @subareas = Subarea.includes(:area).order('area_id asc').page(params[:page])
    if params[:area_id].present?
      @subareas = @subareas.where(area_id: params[:area_id])
    end
    respond_to do |format|
      format.html
      format.json { render json: @subareas}
    end
  end

  def new
    @subarea = Subarea.new
    respond_to do |format|
      format.html
      format.js { render partial: 'ativo_pge/subareas/subarea' }
    end
  end

  def create
    @subarea = Subarea.new(params_subarea)
    if @subarea.save!
      redirect_to ativo_pge_subareas_path, notice: 'Nova Subarea criada, Parabéns!'
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js { render partial: 'ativo_pge/subareas/subarea' }
    end
  end

  def update
    if @subarea.update(params_subarea)
      redirect_to ativo_pge_subareas_path, notice: 'Subarea atualizada, Parabéns!'
    else
      render :edit
    end
  end

  def destroy
    if @subarea.destroy
      redirect_to ativo_pge_subareas_path, notice: 'Subarea excluida, Parabéns!'
    else
      render :index
    end
  end

  private

  def params_subarea
    params.require(:subarea).permit(:description, :area_id)
  end

  def set_subarea
    @subarea = Subarea.find(params[:id])
  end

  def set_area_options
    @area_options = Area.all.pluck(:description, :id)
  end
end
