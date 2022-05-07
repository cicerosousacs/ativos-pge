class AtivoPge::SubareasController < AtivosController
  before_action :set_subarea, only: [:edit, :update, :destroy]
  before_action :set_area_options, only: [:new, :create, :edit, :update]

  def index
    @subareas = Subarea.includes(:area).order("area_id").page(params[:page])
  end

  def new
    @subarea = Subarea.new
  end

  def create
    @subarea = Subarea.new(params_subarea)
    if @subarea.save()
      redirect_to ativo_pge_subareas_path, notice: "Nova Subarea criada, Parabéns!"
    else
      render :new
    end
  end

  def edit
  end

  def change_subarea

    area_id = params[:id].to_i
    sub_areas = Subarea.where(:area => 9)
    area = []
      sub_areas.each do |sub_area|
        area << { :id => sub_area.id, :subarea => sub_area.description }
      end
    render :json => {:area => area.compact}.as_json
  end

  def update
    if @subarea.update(params_subarea)
      redirect_to ativo_pge_subareas_path, notice: "Subarea atualizada, Parabéns!"
    else
      render :edit
    end
  end

  def destroy
    if @subarea.destroy
      redirect_to ativo_pge_subareas_path, notice: "Subarea excluida, Parabéns!"
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
