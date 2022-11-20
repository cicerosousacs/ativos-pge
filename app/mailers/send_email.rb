class SendEmail < ApplicationMailer

  def create_bond(user, email, creation_date, received_asset)
    @user = user
    created_at = DateTime.parse(creation_date)
    @created_at = I18n.l(created_at, format: :long, locale: :'pt-BR')
    @linked_assets = received_asset

    @title = 'Estes são os ativos atribuidos a você:'
    mail to: email, subject: 'Ativos vinculado a você'
  end

  def update_bond(user, email, creation_date, received, removed)
    @user = user
    last_creation_date = DateTime.parse(creation_date)
    created_at = I18n.l(last_creation_date, format: :long, locale: :'pt-BR')
    @received = received
    @removed = removed

    @title = "segue movimentação de ativo de #{created_at}"
    mail to: email, subject: 'Movimentação de ativos vinculado a você'
  end
end
