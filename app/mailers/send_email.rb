class SendEmail < ApplicationMailer
  def create_bond(user, email, creation_date, received_asset)
    @user = user
    @created_at = decode_translate_date(creation_date)
    @linked_assets = received_asset

    @title = 'Estes são os ativos atribuidos a você:'
    mail to: email, subject: 'Ativos vinculado a você'
  end

  def update_bond(user, email, creation_history_date, received, removed)
    @user = user
    created_at = decode_translate_date(creation_history_date)
    @received = received
    @removed = removed
    @last_user = last_user

    @title = "segue movimentação de ativo de #{created_at}"
    mail to: email, subject: 'Movimentação de ativos vinculado a você'
  end

  private

  def decode_translate_date(date)
    decode_date = DateTime.parse(date)
    I18n.l(decode_date, format: :long, locale: :'pt-BR')
  end
end
