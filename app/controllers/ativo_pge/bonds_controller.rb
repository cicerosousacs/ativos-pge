class AtivoPge::BondsController < AtivosController
  before_action :set_bond, only: %i[edit update destroy]
  before_action :set_user_select, only: %i[index new create edit update]
  before_action :set_area_select, only: %i[new create edit update]
  before_action :set_subarea_select, only: %i[new create edit update]
  before_action :set_description_ativo, only: %i[new create edit update]
  before_action :set_tombo_ativo_select, only: %i[new create edit update]
  before_action :set_status, only: %i[new create edit update]

  protect_from_forgery except: :term_responsibility_asset

  def index
    # byebug
    # @q = Bond.joins(:user).where(users: { name: params[:q].values })
    # @q.result.last_bond.page(params[:page]).length == 0
    @q = Bond.ransack(params[:q])
    @bonds = @q.result.last_bond.page(params[:page])
    respond_to do |format|
      format.html
    end
    @total_bonds = Bond.count(:id)
    @users = User.order('name asc')
    @assets = Ativo.order('id asc')
  end

  def new
    @bond = Bond.new
    @bond.call_number.build
  end

  def create
    @bond = Bond.new(params_bond)
    respond_to do |format|
      if @bond.save!
        format.html { redirect_to ativo_pge_bonds_path, notice: "Ativos vinculado: #{@bond.user.name} criado, Parabéns!" }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @bond = Bond.last_bond.find(params[:id])
    respond_to do |format|
      format.js { render partial: 'ativo_pge/bonds/exibir' }
    end
  end

  def edit
    @bond.call_number.build
  end

  def update
    if @bond.update(params_bond)
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

  def term_responsibility_asset
    pdf_data = Pdfs::TermoResponsabilidadeAtivoPdf.gerar(params[:bonds_ids].split(','))
    if params['bonds_ids'].split(',').size == 1
      user_id = Bond.find(params[:bonds_ids]).user_id
      user_name = User.find(user_id).name
      send_data(
        pdf_data, filename: "Termo_Responsabilidade_#{user_name}.pdf", type: 'application/pdf', disposition: 'inline'
      )
    else
      send_data(pdf_data, filename: 'Termo_Responsabilidade.pdf', type: 'application/pdf', disposition: 'inline')
    end
  end

  def history
    @history = BondHistory.where(bond_id: params[:id]).order('created_at desc')
    respond_to do |format|
      format.js { render partial: 'ativo_pge/bonds/history' }
    end
  end

  private

  def params_bond
    params.require(:bond).permit(
      :id, :user_id, :area, :subarea_id, :note, :homeoffice,
      attach_ativo_attributes: %i[id ativo_id description status_id note _destroy],
      call_number_attributes: %i[id number _destroy]
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
    @description_ativo =
      if action_name == 'new'
        Deposit.joins(:ativo).by_deposit.pluck(:ativo_id, :description)
      else
        Deposit.joins(:ativo).available_and_linked.pluck(:description, :ativo_id)
      end
  end

  def set_tombo_ativo_select
    @tombo_ativo =
      if action_name == 'new'
        Deposit.joins(:ativo).by_deposit.pluck('ativos.tombo', 'ativos.id')
      else
        Deposit.joins(:ativo).available_and_linked.pluck('ativos.tombo', 'ativos.id')
      end
  end

  def set_status
    @status =
      if action_name == 'new'
        Status.linked_or_in_use.pluck(:description, :id)
      else
        Status.status_for_edition.pluck(:description, :id)
      end
  end
end
