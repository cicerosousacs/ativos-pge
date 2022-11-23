class AtivoPge::AdminsController < AtivosController
  before_action :check_password, only: [:update]
  before_action :set_admin, only: %i[edit update destroy]

  def index
    @admins = Admin.all.order('id', 'active desc')
  end

  def new
    @admin = Admin.new
    respond_to do |format|
      # format.html
      format.js { render partial: 'ativo_pge/admins/admin' }
    end
  end

  def create
    @admin = Admin.new(params_admin)
    if @admin.save!
      redirect_to ativo_pge_admins_path, notice: "Novo Administrador #{@admin.name} criado. Parabéns!"
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      # format.html
      format.js { render partial: 'ativo_pge/admins/admin' }
    end
  end

  def update
    if @admin.update(params_admin)
      bypass_sign_in(@admin) if @admin.id == current_admin.id
      redirect_to ativo_pge_admins_path, notice: "#{@admin.name} atualizado. Sucesso!"
    else
      render :edit
    end
  end

  def destroy
    if @admin.id == current_admin.id
      flash[:alert] = "#{@admin.name}, você não pode se desativar."
      redirect_to ativo_pge_admins_path and return
    else
      @admin.active = @admin.active ? false : true
      text_message = @admin.active.present? ? 'ativado(a)' : 'inativado(a)'
      @admin.save!
      redirect_to ativo_pge_admins_path, notice: "#{@admin.name} #{text_message} com sucesso!"
    end
  end

  private

  def params_admin
    params.require(:admin).permit(:name, :email, :active, :password, :password_confirmation, :profile)
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def check_password
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)
    end
  end
end
