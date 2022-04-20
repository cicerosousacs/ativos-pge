class AtivoPge::BondsController < AtivosController
  before_action :set_bond, only: [:edit, :update, :destroy]
  before_action :set_user_select, only: [:new, :create, :edit, :update]
  before_action :set_area_select, only: [:new, :create, :edit, :update]
  before_action :set_subarea_select, only: [:new, :create, :edit, :update]
  before_action :set_ativo_select, only: [:new, :create, :edit, :update]

  def index
    @bonds = Bond.last_bond.order("created_at DESC")
  end

  def new
    @bond = Bond.new
  end

  def create
    @bond = Bond.new(params_bond)
    if @bond.save()
      redirect_to ativo_pge_bonds_path, notice: "Vinculo criado, Parabéns!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @bond.update(params_bond)
      redirect_to ativo_pge_bonds_path, notice: "Vinculo atualizado, Sucesso!"
    else
      render :edit
    end
  end

  def destroy
    if @bond.destroy
      redirect_to ativo_pge_bonds_path, notice: "Vinculo excluido, Sucesso!"
    else
      render :index
    end
  end

  private

  def params_bond
    params.require(:bond).permit(
                                :user_id,
                                :area, 
                                :subarea_id, 
                                :note,
                                attach_ativo_attributes: [:id, :ativo_id, :description, :status, :note, :_destroy]
                                )
  end

  def set_bond
    @bond = Bond.find(params[:id])
  end

  def set_user_select
    @user_select = User.pluck(:name, :id)
  end

  def set_area_select
    @area_select = Area.pluck(:description, :id)
  end

  def set_subarea_select
    @subarea_select = Subarea.pluck(:description, :id)
  end

  def set_ativo_select
    @ativo_select = Ativo.pluck(:tombo, :id)
  end

end
