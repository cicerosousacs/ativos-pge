class AtivoPge::DepositsController < AtivosController
  before_action :set_deposit, only: [:edit, :update]
  before_action :set_status, only: [:edit, :update]

  def index
    @deposits = Deposit.teste.available.order('id desc').page(params[:page])
    @qtd_available = Deposit.available_at
    @qtd_defect = Deposit.defect
    @qtd_unusable = Deposit.unusable
    @qtd_awaiting_warranty = Deposit.awaiting_warranty
  end

  def edit
    respond_to do |format|
      format.js { render partial: 'ativo_pge/deposits/deposit' }
    end
  end

  def update
    if @deposit.update(params_deposit)
      redirect_to ativo_pge_deposits_path, notice: "Status atualizado. Sucesso!"
    else
      render :edit
    end
  end

  private

  def params_deposit
    params.require(:deposit).permit(:ativo_id, :description, :status_id, :observation)
  end

  def set_deposit
    @deposit = Deposit.find(params[:id])
  end

  def set_status
    @status = Status.status_in_warehouse.pluck(:description, :id)
  end
end
