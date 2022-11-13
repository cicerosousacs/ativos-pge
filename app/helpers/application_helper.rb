module ApplicationHelper
  def last_movement(bond)
    if bond.updated_at > bond.attach_ativo.last.updated_at
      bond.updated_at.strftime("%d/%m/%Y %H:%M")
    else
      bond.attach_ativo.last.updated_at.strftime("%d/%m/%Y %H:%M")
    end
  end
end
