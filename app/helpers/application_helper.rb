module ApplicationHelper
  def last_movement(bond)
    if bond.updated_at > bond.attach_ativo.last.updated_at
      I18n.l(bond.updated_at, format: :half_short, locale: :'pt-BR')
    else
      I18n.l(bond.attach_ativo.last.updated_at, format: :half_short, locale: :'pt-BR')
    end
  end

  def last_call_number(bond)
    if bond.call_number.last.present?
      bond.call_number.last.number
    else
      'Não informado'
    end
  end

  def tombo_asset(id)
    asset = Ativo.find_by_id(id)
    asset.tombo
  end
end
