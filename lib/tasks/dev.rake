namespace :dev do
  DEFAULT_PASSWORD = '@tivos_2022'
  DEFAULT_FILE_PATH = File.join(Rails.root, 'tmp')

  desc "Configurando o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      # show_spinner("Apagando BD...") { %x(rails db:drop:_unsafe) }
      # show_spinner("Criando BD...") { %x(rails db:create) }
      # show_spinner('Migrando BD...') { %x(rails db:migrate) }
      show_spinner('Admin padrão...') { %x(rails dev:add_default_admin) }
      show_spinner('Ajustes 1 de 4...') { %x(rails dev:add_areas) }
      show_spinner('Ajustes 2 de 4...') { %x(rails dev:add_users) }
      show_spinner('Ajustes 3 de 4...') { %x(rails dev:add_status) }
      show_spinner('Ajustes 4 de 4...') { %x(rails dev:add_acquisition) }
      #show_spinner('Ajustes 5 de 5...') { %x(rails dev:add_modalidade) }
    else
      puts 'Você não esta em ambiente de desenvolvimento!'
    end
  end

  desc 'Adiciona o administrador padrão'
  task add_default_admin: :environment do
    Admin.create!(
      name: 'Administrador',
      email: 'admin@pge.ce.gov.br',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc 'Adicionando Areas'
  task add_areas: :environment do
    file_name = 'areas.txt'
    file_path = File.join(DEFAULT_FILE_PATH, file_name)

    File.open(file_path, 'r').each do |line|
    Area.create!(description: line.strip)
    end
  end

  desc 'Adicionando Usuarios'
  task add_users: :environment do
    # file_name = 'usuarios.txt'
    # file_path = File.join(DEFAULT_FILE_PATH, file_name)
    # File.open(file_path, 'r').each do |line|
    # User.create!(
    #   name: line[0],
    #   email: line[1]
    #   )
    # end
    show_spinner('Adicionando Usuários...') do
      500.times do |i|
        User.create!(
          name: Faker::Name.name,
          email: Faker::Internet.email(domain: 'pge.ce.gov.br'),
        )
      end
    end
  end

  desc 'Adicionando Status'
  task add_status: :environment do
    show_spinner('Adicionando Status...') do
      Status.create!(
        [
          { description: 'DISPONÍVEL' },
          { description: 'DEFEITO' },
          { description: 'INSERVÍVEL' },
          { description: 'AGUARDANDO GARANTIA' },
          { description: 'VÍNCULADO' },
          { description: 'VÍNCULADO EM USO' }
        ]
      )
    end
  end

  desc 'Adicionando Aquisição Padrão'
  task add_acquisition: :environment do
    show_spinner('Adicionando Aquisição Padrão...') do
      Acquisition.create!(
        item: 'Ativos já existentes',
        quantity: 3318,
        value_acquisition: 300_000_00,
        manager: 'PGE',
        acquisition_date: '01/01/2000',
        modality: 'PREGÃO',
        contract_number: '01/0000',
        source: 'MAPP',
        company: 'PGE',
        interested_party: 'PGE',
        warranty_ends: '01/01/2005',
        warranty_period: 60,
        observations: 'PGE'
      )
    end
  end

  desc 'Contador de Ativos por Tipo'
  task count_ativos: :environment do
    show_spinner('Calculando quantidade de Ativos...') do
      Ativo.find_each do |type|
        Ativo.reset_counters(type, :ativos)
      end
    end
  end

  private

  def show_spinner(msg_start, msg_end = 'Sucesso!')
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
