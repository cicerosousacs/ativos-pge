require 'csv'

namespace :csv do
  desc "Importa o arquivo dados.csv"
  task import: :environment do
    show_spinner("Importando Ativos...") do
      CSV.foreach('tmp/ativos2PGE.csv', col_sep: ',').with_index do |linha, indice|
        unless (indice == 0)
          Ativo.find_or_create_by!(
            type: linha[0],
            tombo: linha[1], 
            serial: linha[2],
            model: linha[3],
            brand: linha[4],
            acquisition_id: "1")
        end
      end
    end
  end
end
