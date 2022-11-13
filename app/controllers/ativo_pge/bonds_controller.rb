class AtivoPge::BondsController < AtivosController
  before_action :set_bond, only: [:edit, :update, :destroy]
  before_action :set_user_select, only: [:new, :create, :edit, :update]
  before_action :set_area_select, only: [:new, :create, :edit, :update]
  before_action :set_subarea_select, only: [:new, :create, :edit, :update]
  before_action :set_description_ativo, only: [:new, :create, :edit, :update]
  before_action :set_tombo_ativo_select, only: [:new, :create, :edit, :update]
  before_action :set_status, only: [:new, :create, :edit, :update]

  protect_from_forgery except: :pdf_termo_responsabilidade_ativo

  def index
    # @bonds = Bond.order(:id)
    @q = Bond.ransack(params[:q])
    @bonds = @q.result.order(:id).page(params[:page])
    @total_bonds = Bond.count(:id)
    respond_to do |format|
      format.html { @bonds = Bond.last_bond.page(params[:page]) }
    end
  end

  def pdf_termo_responsabilidade_ativo
    pdf_data = Pdfs::TermoResponsabilidadeAtivoPdf.gerar(params[:bonds_ids].split(','))
    if params['bonds_ids'].split(',').size == 1
      user_id = Bond.find(params[:bonds_ids]).user_id
      user_name = User.find(user_id).name
      send_data(pdf_data, filename: "Termo_Responsabilidade_#{user_name}.pdf", :type => 'application/pdf', :disposition => 'inline')
    else
      send_data(pdf_data, filename: 'Termo_Responsabilidade.pdf', :type => 'application/pdf', :disposition => 'inline')
    end
  end

  def new
    @bond = Bond.new
    @bond.call_number.build
  end

  def create
    @bond = Bond.new(params_bond)
    respond_to do |format|
      if @bond.save!
        SendEmail.create_bond(@bond).deliver_later
        format.html { redirect_to ativo_pge_bonds_path, notice: "Ativos vinculado: #{@bond.user.name} criado, Parabéns!"}
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
    @bond.call_number.build
  end

  def update
    if @bond.update(params_bond)
      SendEmail.update_bond(@bond).deliver_later
      redirect_to ativo_pge_bonds_path, notice: "Vinculo de #{@bond.user.name}, atualizado com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    if @bond.destroy
      redirect_to ativo_pge_bonds_path, notice: 'Vinculo excluido, Sucesso!'
    else
      render :index
    end
  end

  private

  def params_bond
    params.require(:bond).permit(
      :id, :user_id, :area, :subarea_id, :note, :homeoffice,
      attach_ativo_attributes: [ :id, :ativo_id, :description, :status_id, :note, :_destroy ],
      call_number_attributes: [ :id, :number, :_destroy ]
    )
  end

  def set_bond
    @bond = Bond.find(params[:id])
  end

  def set_user_select
    @user_select = User.order('name asc').pluck(:name, :id)
  end

  def set_area_select
    @area_select = Area.pluck(:description, :id)
  end

  def set_subarea_select
    @subarea_select = Subarea.pluck(:description, :id)
  end

  def set_description_ativo
    if action_name == 'new'
      @description_ativo = Deposit.joins(:ativo).by_deposit.pluck(:ativo_id, :description)
    else
      @description_ativo = Deposit.joins(:ativo).available_and_linked.pluck(:description, :ativo_id)
    end
  end

  def set_tombo_ativo_select
    if action_name == 'new'
      @tombo_ativo = Deposit.joins(:ativo).by_deposit.pluck('ativos.tombo', 'ativos.id')
    else
      @tombo_ativo = Deposit.joins(:ativo).available_and_linked.pluck('ativos.tombo', 'ativos.id')
    end
  end

  def set_status
    if action_name == 'new'
      @status = Status.linked_or_in_use.pluck(:description, :id)
    else
      @status = Status.status_for_edition.pluck(:description, :id)
    end
  end
end
