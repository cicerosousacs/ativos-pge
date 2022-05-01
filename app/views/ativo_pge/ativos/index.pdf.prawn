prawn_document do |pdf|
  pdf.text 'Relação de Ativos', :align => :center
  pdf.move_down 20
  pdf.table @ativos.collect{|a| [a.tombo, a.type, a.brand, a.model, a.serial]}
end