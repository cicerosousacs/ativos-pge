class SendEmail < ApplicationMailer

  def create_bond(bond)
    @user = bond.user.name
    @created_at = I18n.l(bond.created_at, format: :long, locale: :'pt-BR')
    @linked_assets = bond.attach_ativo

    email = bond.user.email
    mail to: email, subject: 'Ativos vinculado a você'
  end

  def update_bond(bond)
    last_asset_update = bond.attach_ativo.last.updated_at
    last_bond_update = bond.updated_at
    last_update = last_bond_update > last_asset_update
    linked_assets = bond.attach_ativo.where(created_at: Date.today.all_day)
    @linked = linked_assets.to_a
    @user = bond.user.name
    email = bond.user.email
    @updated_at = last_update ? last_bond_update : last_asset_update

    @title = "segue movimentação de ativo de #{I18n.l(@updated_at, format: :long, locale: :'pt-BR')}"
    mail to: email, subject: 'Movimentação de ativos vinculado a você'
  end
end
