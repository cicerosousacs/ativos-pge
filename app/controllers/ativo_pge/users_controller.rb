class AtivoPge::UsersController < AtivosController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.page(params[:page]).order("name")
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html
      format.js { render partial: 'ativo_pge/users/user' }
    end
  end

  def create
    @user = User.new(params_user)
    if @user.save()
      redirect_to ativo_pge_users_path, notice: "Usuário criado. Parabéns!"
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js { render partial: 'ativo_pge/users/user' }
    end
  end

  def update
    if @user.update(params_user)
      redirect_to ativo_pge_users_path, notice: "Usuário atualizado. Sucesso!"
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to ativo_pge_users_path, notice: "Usuário excluido. Feito!"
    else
      render :index
    end
  end

  private

  def params_user
    params.require(:user).permit(:name, :has_many_bond, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
