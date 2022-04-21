namespace :dev do

  DEFAULT_PASSWORD = '@tivos_2022'
  DEFAULT_FILE_PATH = File.join(Rails.root, 'tmp')
  
    desc "Configura o ambiente de desenvolvimento"
    task setup: :environment do
      if Rails.env.development?
        #show_spinner("Apagando BD...") { %x(rails db:drop:_unsafe) }
        #show_spinner("Criando BD...") { %x(rails db:create) }
        #show_spinner("Migrando BD...") { %x(rails db:migrate) }
        show_spinner("Admin padrão...") { %x(rails dev:add_default_admin) }
        show_spinner("Ajustes 1 de 5...") { %x(rails dev:add_areas) }
        #show_spinner("Ajustes 2 de 5...") { %x(rails dev:add_marca) }
        #show_spinner("Ajustes 3 de 5...") { %x(rails dev:add_condicao) }
        #show_spinner("Ajustes 4 de 5...") { %x(rails dev:add_origem) }
        #show_spinner("Ajustes 5 de 5...") { %x(rails dev:add_modalidade) }
      else
        puts "Você não esta em ambiente de desenvolvimento!"
      end
    end
    
    desc "Adiciona o administrador padrão"
    task add_default_admin: :environment do
      Admin.create!(
        #nome: 'Admin',
        email: 'admin@ativos.pge',
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
     
    desc "Adicionando Areas"
    task add_areas: :environment do
      file_name = 'areas.txt'
      file_path = File.join(DEFAULT_FILE_PATH, file_name)
  
      File.open(file_path, 'r').each do |line|
      Area.create!(description: line.strip)
      end
    end

##################################################################
    desc "Contador de Ativos por Tipo"
    task count_ativos: :environment do
      show_spinner("Calculando quantidade de Ativos...") do
        Ativo.find_each do |type|
          Ativo.reset_counters(type, :ativos)
        end
      end
    end
##################################################################
    private
     
    def show_spinner(msg_start, msg_end = "Sucesso!")
      spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
      spinner.auto_spin
      yield
      spinner.success("(#{msg_end})") 
    end
  
  end  
