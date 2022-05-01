include ApplicationHelper

module Pdfs
  class AtivoPdf
    def self.gerar(ativos)
      pdf = Prawn::Document.new(:page_size => "A4", :page_layout => :portrait) do |pdf|
        Bond.where(type: ativos).each_with_index do |ativo, i|
          pdf.start_new_page if i > 0
          w = pdf.bounds.width
          h = pdf.bounds.height

          pdf.draw_text "Data de emissão: #{Time.now.strftime('%d/%m/%Y %H:%M')}", :at => [0, h], :size => 10
          pdf.image "#{Rails.root}/app/assets/images/logo_pge_center.png", :position => :center, :width => 120
          pdf.move_down 10
          pdf.text "Coordenadoria de Tecnologia da Informação - CTI", :align => :center, :size => 12	, :style => :italic
          pdf.move_down 10

          dados_cabecalho = []
          dados_cabecalho[0] = []
          dados_cabecalho[0].push("<b>Area</b>\n#{ativo.type}")
          dados_cabecalho[0].push("<b>Subarea</b>\n#{ativo.model}")
          dados_cabecalho[1] = []
          dados_cabecalho[1].push("<b>Usuário</b>\n#{ativo.brand}")
          dados_cabecalho[2] = []
          dados_cabecalho[2].push("<b>Observações</b>\n#{ativo.tombo}")

          pdf.table([dados_cabecalho[0]]) do |t|
            t.column_widths= [370, 150]
            t.row(0..1).style(:align => :left, :size => 9, :inline_format => true)
          end
          pdf.table([dados_cabecalho[1]]) do |t|
            t.column_widths= [520]
            t.row(0..1).style(:align => :left, :size => 9, :inline_format => true)
          end
          pdf.table([dados_cabecalho[2]]) do |t|
            t.column_widths= [173.3,173.3,173.3]
            t.row(0..1).style(:align => :left, :size => 9, :inline_format => true)
          end
        end  
      end  
    end
  end
end
  