class AtivoPge::BondsController < AtivosController
  before_action :set_bond, only: [:edit, :update, :destroy]
  before_action :set_user_select, only: [:new, :create, :edit, :update]
  before_action :set_area_select, only: [:new, :create, :edit, :update]
  before_action :set_subarea_select, only: [:new, :create, :edit, :update]
  before_action :set_ativo_select, only: [:new, :create, :edit, :update]

  protect_from_forgery except: :pdf_termo_responsabilidade_ativo

  def index
    respond_to do |format|
      format.html { @bonds = Bond.last_bond }
    end
  end

  def pdf_termo_responsabilidade_ativo
    pdf_data = Pdfs::TermoResponsabilidadeAtivoPdf.gerar((params[:bonds_ids]).split(','))
    if params["bonds_ids"].split(',').size == 1
      usuario_vinculo = Bond.where('id = ?', params["bonds_ids"].split(',')).first.user_id
      send_data(pdf_data, filename: "termo_#{usuario_vinculo}.pdf", :type => 'application/pdf', :disposition => 'inline')
    else
      send_data(pdf_data, filename: "termo.pdf", :type => 'application/pdf', :disposition => 'inline')
    end
  end

  def new
    @bond = Bond.new
    @ativos = Ativo.all
  end

  def create
    @bond = Bond.new(params_bond)
    respond_to do |format|
      if @bond.save!
        format.html { redirect_to ativo_pge_bonds_path, notice: "Vinculo criado, Parabéns!" }
        format.json { render json: @bond }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @bonds = Bond.last_bond.find(params[:id])
    respond_to do |format|
      format.js { render partial: 'ativo_pge/bonds/exibir' }
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
                                :homeoffice,
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
