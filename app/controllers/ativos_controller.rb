class AtivosController < ApplicationController
  layout 'ativos_pge'
  before_action :authenticate_admin!
end
