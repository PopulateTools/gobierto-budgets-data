require "zlib"

class DataImport

  attr_reader :year, :what

  def initialize(database, what, year = nil)
    raise 'Missing database name' if database.blank?
    raise 'Invalid type option' unless %{ planned executed }.include?(what)

    @database = database
    @what = what
    @year = year.to_s if year.present?
  end

  def import_in_database
    Dir.foreach(Rails.root.join('data/presupuestos_municipales')) do |directory|
      next if ['.', '..'].include?(directory)
      next if directory.to_s != year if year.present?

      current_year = directory.to_s
      full_path_directory = Rails.root.join("data/presupuestos_municipales/#{current_year}/#{what}")
      if File.directory?(full_path_directory)
        import_year_data(full_path_directory, current_year)
      else
        raise "[ERROR] Directory #{directory} does not exist"
      end
    end
  end

  private

  def import_year_data(folder, year)
    puts "- Importing data from #{folder}"

    Dir.glob("#{folder}/tb_*.sql.gz").each do |file|
      import_file(file, year)
    end

    format_imported_data(year)
  end

  def import_file(file, year)
    puts "- Importing file #{file}"
    table_name = File.basename(file, '.sql.gz')

    Zlib::GzipReader.open(file) do |gz|
      import_sql_file(gz.read, table_name)
    end

    puts "- Imported file #{file} in database #{@database}"

    db.execute(%Q{DROP TABLE IF EXISTS "#{table_name}_#{year}" CASCADE;})
    db.execute(%Q{ALTER TABLE "#{table_name}" RENAME TO "#{table_name}_#{year}"})
    puts "- Renamed table to #{table_name}_#{year}"
    puts
  end

  def import_sql_file(sql, table_name)
    first_line = sql[0..100]
    unless first_line =~ /begin/i
      first_str = %Q{ BEGIN; DROP INDEX IF EXISTS "#{table_name}tipreig"; DROP INDEX IF EXISTS "#{table_name}cdfgr"; }
      last_str = "COMMIT;"

      sql = first_str + "\n" + sql + "\n" + last_str
    end

    db.execute(sql)
  end

  def db
    @db ||= begin
      ActiveRecord::Base.establish_connection ActiveRecord::Base.configurations.configs_for(env_name: Rails.env).find{ |c| c.name == @database }
      ActiveRecord::Base.connection
    end
  end

  def format_imported_data(year)
    if @database == 'budgets-planned'
       db.execute(<<SQL)
update "tb_economica_cons_#{year}" set cdcta = LTRIM(RTRIM(cdcta));
update "tb_funcional_cons_#{year}" set cdcta = LTRIM(RTRIM(cdcta));
update "tb_funcional_cons_#{year}" set cdfgr = LTRIM(RTRIM(cdfgr));
SQL
    end
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
