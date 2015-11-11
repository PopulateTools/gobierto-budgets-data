class PresupuestosMunicipales::DataImport

  def import_in_database!
    Dir.foreach(File.expand_path('../', __FILE__)) do |directory|
      next if ['.', '..'].include?(directory)
      year = directory

      directory = File.expand_path('../' + directory, __FILE__)
      if File.directory?(directory)
        import_year_data(directory, year)
      end
    end
  end

  private

  def import_year_data(folder, year)
    base_path = folder + '/archive/'
    Dir.foreach(base_path) do |file|
      if relevant_file?(file)
        import_file(base_path + file, year)
      end
    end

    ActiveRecord::Base.connection.execute(<<SQL)
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

  def relevant_file?(file)
    file =~ /\Atb_.+\.sql\.gz\z/
  end

  def import_file(file, year)
    table_name = File.basename(file, '.sql.gz')
    %x(gunzip < #{file} | psql #{ActiveRecord::Base.configurations[Rails.env]['database']})

    puts "Imported file #{file}"

    ActiveRecord::Base.connection.execute(%Q{ALTER TABLE "#{table_name}" RENAME TO "#{table_name}_#{year}"})
    puts "Renamed table to #{table_name}_#{year}"
    puts
  end
end


PresupuestosMunicipales::DataImport.new.import_in_database!
