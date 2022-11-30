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
    if history.removed.blank?
      'Data da vinculação:'
    elsif history.received.blank? && history.removed.blank? && history.allocation_id.present?
      'Data da nova lotação:'
    else
      'Data da movimentação de ativos:'
    end
  end

  def modality
    Acquisition.modalities.keys
  end

  def sources
    Acquisition.sources.keys
  end

  def type
    Ativo.types.keys
  end

  def allocation(id)
    subarea = Subarea.find_by_id(id)
    area_name = subarea.description
    subarea_name = subarea.area.description
    [subarea_name, area_name].join(' - ')
  end

  def translate_attribute(object = nil, attribute = nil)
    object && attribute ? object.model.human_attribute_name(attribute) : 'Sem tradução'
  end

  def inactivate_activate(admin)
    admin.active.present? ? 'inativar' : 'ativar'
  end

  def form_title(action, model)
    if action == 'new'
      t(new_or_newa(model), model: model.model_name.human)
    else
      t('title.update_form', name: model_attribute(model))
    end
  end

  def model_attribute(model)
    if model.instance_of?(::Area)
      model.description
    elsif model.instance_of?(::Subarea)
      model.description
    else
      model.name
    end
  end

  def new_or_newa(model)
    if model.instance_of?(::User)
      'title.new_form'
    elsif model.instance_of?(::Admin)
      'title.new_form'
    else
      'title.newa_form'
    end
  end
end
