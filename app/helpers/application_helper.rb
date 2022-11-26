module ApplicationHelper
  def last_movement(bond)
    if bond.updated_at > bond.attach_ativo.last.updated_at
      translete_date_half_sort(bond.updated_at)
    else
      translete_date_half_sort(bond.attach_ativo.last.updated_at)
    end
  end

  def last_call_number(bond)
    bond.call_number.last.present? ? bond.call_number.last.number : 'Não informado'
  end

  def tombo_asset(id)
    Ativo.find_by_id(id).tombo
  end

  def translate_date(date)
    I18n.l(date, format: :long, locale: :'pt-BR')
  end

  def translete_date_half_sort(date)
    I18n.l(date, format: :half_short, locale: :'pt-BR')
  end

  def text_date_history(history)
    if history.removed.nil?
      'Data da vinculação:'
    elsif history.received.blank? && history.removed.blank?
      'Data da vinculação:'
    else
      'Data da movimentação:'
    end
  end

  def modality
    Acquisition.modalities.keys
  end

  def sources
    Acquisition.sources.keys
  end

  def allocation(id)
    subarea = Subarea.find_by_id(id)
    area_name = subarea.description
    subarea_name = subarea.area.description
    [subarea_name, area_name].join(' - ')
  end
end
