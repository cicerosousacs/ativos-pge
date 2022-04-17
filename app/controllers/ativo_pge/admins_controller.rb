class AtivoPge::AdminsController < AtivosController
  before_action :check_senhas, only: [:update]
  before_action :set_admin, only: [:edit, :update, :destroy]
  
  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params_admin)
      if @admin.save()
        redirect_to ativo_pge_admins_path, notice: "Novo Administrador criado. Parabéns!"
      else
        render :new
      end
  end

  def edit
  end

  def update
    if @admin.update(params_admin)
      sign_in(@admin, bypass: true)
      redirect_to ativo_pge_admins_path, notice: "Administrador atualizado. Sucesso!"
    else
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      redirect_to ativo_pge_admins_path, notice: "Administrador removido. Feito!"
    else
      render :index
    end
  end

  private

  def params_admin
    params.require(:admin).permit(:email, :password, :password_confirmation)#:nome, , :status
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def check_senhas
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)
    end
  end

end
