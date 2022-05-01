include ApplicationHelper
module Pdfs
  class TermoResponsabilidadeAtivoPdf
    def self.gerar(array_id_bond)
      pdf = Prawn::Document.new(:page_size => "A4", :page_layout => :portrait) do |pdf|
        Bond.where(id: array_id_bond).each_with_index do |bond, i|
          pdf.start_new_page if i > 0
          w = pdf.bounds.width
          h = pdf.bounds.height

          pdf.image "#{Rails.root}/app/assets/images/logo_pge_center.png", :position => :center, :width => 120
          pdf.move_down 50
          pdf.text "TERMO DE EMPRÉSTIMO", :align => :center, :size => 12	, :style => :bold
          pdf.move_down 10
         
          pdf.move_down 10
          pdf.text "Pelo presente termo, declaro receber, na condição de empréstimo, os equipamentos listados, pertencente à Procuradoria-Geral do Estado do Ceará - PGE, que serão utilizados no período conforme o estabelecido por Decreto do Governador do Estado do Ceará em virtude do COVID-19.

          Declaro outrossim, que os equipamentos foram recebidos em funcionamento e em bom estado de conservação e que ficarei responsável por sua guarda e conservação.", :size => 12, align: :justify
          pdf.move_down 20

          pdf.move_down 20
          pdf.text "Nome: #{bond.user.name}", :size => 12, :style => :italic, align: :left
          pdf.move_down 5
          pdf.text "CPF:", :size => 12, :style => :italic, align: :left
          pdf.move_down 5
          pdf.text "Setor: #{bond.subarea.area.description}", :size => 12, :style => :italic, align: :left
          pdf.move_down 20

          pdf.move_down 20
          pdf.text "ATIVOS VINCULADOS ", :size => 10, :style => :bold, align: :center
          pdf.move_down 20

          data = Array.new
          data << ["Tombo","Descrição","Serial"]

          bond.attach_ativo.each do |ativo|
            data_dados = Array.new
            data_dados << ativo.ativo.tombo
            data_dados << ativo.ativo.ativo_description 
            data_dados << ativo.ativo.serial
            data << data_dados
          end

          pdf.table(data, :width => 520, :cell_style => { size: 10}) do |t|
            t.row(0).style :background_color => 'E8E8E8', :font_style => :bold
          end

          pdf.move_down 50
          pdf.text "Fortaleza, #{I18n.l(Time.now, format: "%d de %B de %Y")}", :size => 12, :style => :italic, align: :left


          pdf.move_down 15

          pdf.move_down 50
          pdf.text "___________________________________________________", :size => 10, :style => :bold, align: :center
          pdf.move_down 5
          pdf.text "Assinatura", :size => 12, :style => :italic, align: :center
          pdf.move_down 10
          

        end  
      end  
      return pdf.render
    end
  end
end