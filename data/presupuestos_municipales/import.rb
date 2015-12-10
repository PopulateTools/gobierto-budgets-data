class PresupuestosMunicipales::DataImport

  def import_in_database!
    # years = [2010,2011,2012,2013,2014,2015]
    Dir.foreach(File.expand_path('../', __FILE__)) do |directory|
      next if ['.', '..'].include?(directory)
      year = directory

      directory = File.expand_path('../' + directory, __FILE__)
      if File.directory?(directory)
        import_year_data(directory, year)
      end
    end

    # create_yearable_tables
    #
    # TODO: we don't need this, because we read the data from each year table
    #     years.each do |year|
    #       sql = <<-SQL
    # insert into tb_economica (id, idente, tipreig, cdcta, importe, year)
    # select id, idente, tipreig, cdcta, importe, #{year} as year
    # FROM tb_economica_#{year}
    # SQL
    # 
    #       ActiveRecord::Base.connection.execute(sql)
    # 
    #       sql = <<-SQL
    # insert into tb_funcional (id, idente, cdcta, cdfgr, importe, year)
    # select id, idente, cdcta, cdfgr, importe, #{year} as year
    # FROM tb_funcional_#{year}
    # SQL
    # 
    #       ActiveRecord::Base.connection.execute(sql)
    #     end
    # TODO: do we need to rename the tables?
    # ActiveRecord::Base.connection.execute(%Q{ALTER TABLE "tb_cuentasEconomica_2015" RENAME TO "tb_cuentasEconomica"})
    # ActiveRecord::Base.connection.execute(%Q{ALTER TABLE "tb_cuentasProgramas_2015" RENAME TO "tb_cuentasProgramas"})
    # ActiveRecord::Base.connection.execute(%Q{ALTER TABLE tb_inventario_2015 RENAME TO tb_inventario})

    # TODO: remove the tables that are not used anymore (the tables with a year in the suffix)
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

  def create_yearable_tables
sql = <<-SQL
DROP TABLE IF EXISTS tb_funcional;
CREATE TABLE "tb_funcional" (
        "id" NUMERIC(15,2),
        "idente" NUMERIC(15,2),
        "cdcta" VARCHAR(6),
        "cdfgr" VARCHAR(6),
        "importe" NUMERIC(15,2),
        "year" smallint
);

DROP TABLE IF EXISTS tb_economica;
CREATE TABLE "tb_economica" (
        "id" NUMERIC(15,2),
        "idente" NUMERIC(15,2),
        "tipreig" VARCHAR(1),
        "cdcta" VARCHAR(6),
        "importe" NUMERIC(15,2),
        "year" smallint
);
SQL

    ActiveRecord::Base.connection.execute(sql)
  end
end

PresupuestosMunicipales::DataImport.new.import_in_database!
