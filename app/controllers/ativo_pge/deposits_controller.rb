class AtivoPge::DepositsController < AtivosController
  before_action :set_deposit, only: %i[edit update]
  before_action :set_status, only: %i[edit update]

  def index
    @deposits = Deposit.status_warehouse(params[:status]).order('id desc').page(params[:page])
    @qtd_available = Deposit.available_size
    @qtd_defect = Deposit.defect_size
    @qtd_unusable = Deposit.unusable_size
    @qtd_awaiting_warranty = Deposit.awaiting_warranty_size
    @status = Status.status_in_warehouse.select(:id, :description)
  end

  def edit
    respond_to do |format|
      format.js { render partial: 'ativo_pge/deposits/deposit' }
    end
  end

  def update
    if @deposit.update(params_deposit)
      redirect_to ativo_pge_deposits_path, notice: "O status do #{@deposit.description}, foi atualizado."
    else
      render :edit
    end
  end

  private

  def params_deposit
    params.require(:deposit).permit(:ativo_id, :description, :status_id, :observation, :status)
  end

  def set_deposit
    @deposit = Deposit.find(params[:id])
  end

  def set_status
    @status = Status.status_in_warehouse.pluck(:description, :id)
  end
end
