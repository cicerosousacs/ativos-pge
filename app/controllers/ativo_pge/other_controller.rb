class AtivoPge::OtherController < AtivosController
  def index
    @areas = Area.page(params[:page])
    @subareas = Subarea.page(params[:page])
    @users = User.page(params[:page])
  end

  private


end
