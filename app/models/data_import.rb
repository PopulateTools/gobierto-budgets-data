class DataImport

  def initialize(database, what, year = nil)
    raise 'Missing database name' if database.blank?
    raise 'Invalid type option' unless %{ planned executed }.include?(what)

    @database = database
    @what = what
    @year = year
  end

  def import_in_database
    Dir.foreach(Rails.root.join('data/presupuestos_municipales')) do |directory|
      next if ['.', '..'].include?(directory)
      if @year
        next if directory.to_s != @year.to_s
      end
      year = directory

      directory = Rails.root.join("data/presupuestos_municipales/#{year}")
      if File.directory?(directory)
        import_year_data(directory, year)
      end
    end
  end

  private

  def import_year_data(folder, year)
    base_path = "#{folder}/#{@what}/"
    return unless File.directory?(base_path)

    executed = false
    Dir.foreach(base_path) do |file|
      if relevant_file?(file)
        executed = true
        import_file(base_path + file, year)
      end
    end

    if executed
      format_planned_data(year)
      format_data(year)
    end
  end

  def relevant_file?(file)
    file =~ /\Atb_.+\.sql\.gz\z/
  end

  def import_file(file, year)
    table_name = File.basename(file, '.sql.gz')
    %x(gunzip -f #{file})

    dir = File.join(File.dirname(file),"")
    sql_file = dir + File.basename(file, '.gz')
    first_line = File.readlines(sql_file).first.chomp
    if not first_line =~ /begin/i
      import_speedup(sql_file,%Q{BEGIN; DROP INDEX IF EXISTS "#{table_name}tipreig"; DROP INDEX IF EXISTS "#{table_name}cdfgr";}, 'COMMIT;')
    end

    %x(cat #{sql_file} | psql #{@database})
    puts "Imported file #{file} in database #{@database}"

    db.execute(%Q{DROP TABLE IF EXISTS "#{table_name}_#{year}" CASCADE;})
    db.execute(%Q{ALTER TABLE "#{table_name}" RENAME TO "#{table_name}_#{year}"})
    puts "Renamed table to #{table_name}_#{year}"
    puts
    File.delete(sql_file)
  end

  def import_speedup(file, first_srt, last_str)
    new_contents = ""
    File.open(file, 'r') do |fd|
      contents = fd.read
      new_contents = first_srt + "\n" + contents + "\n" + last_str
    end
    File.open(file, 'w') do |fd|
      fd.write(new_contents)
    end
  end

  def db
    @db ||= begin
              ActiveRecord::Base.establish_connection ActiveRecord::Base.configurations[Rails.env].merge('database' => @database)
              ActiveRecord::Base.connection
            end
  end

  def format_planned_data(year)
    if @database == 'budgets-planned'
       db.execute(<<SQL)
update "tb_economica_cons_#{year}" set cdcta = LTRIM(RTRIM(cdcta));
update "tb_funcional_cons_#{year}" set cdcta = LTRIM(RTRIM(cdcta));
update "tb_funcional_cons_#{year}" set cdfgr = LTRIM(RTRIM(cdfgr));
SQL
    end
  end

  def format_data(year)
    db.execute(<<SQL)
update "tb_cuentasEconomica_#{year}" set cdcta = LTRIM(RTRIM(cdcta));
update "tb_cuentasEconomica_#{year}" set nombre = LTRIM(RTRIM(nombre));
update "tb_cuentasProgramas_#{year}" set cdfgr = LTRIM(RTRIM(cdfgr));
update "tb_cuentasProgramas_#{year}" set nombre = LTRIM(RTRIM(nombre));
update "tb_economica_#{year}" set cdcta = LTRIM(RTRIM(cdcta));
update "tb_funcional_#{year}" set cdcta = LTRIM(RTRIM(cdcta));
update "tb_funcional_#{year}" set cdfgr = LTRIM(RTRIM(cdfgr));
update tb_inventario_#{year} set nombreente = LTRIM(RTRIM(nombreente));
update tb_inventario_#{year} set nombreppal = LTRIM(RTRIM(nombreppal));
SQL
  end
end
