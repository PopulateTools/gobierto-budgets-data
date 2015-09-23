class PresupuestosMunicipales::DataExport
  def initialize(ine_place)
    @ine_place = ine_place
    @destination_folder = "/tmp/presupuestos_municipales_#{@ine_place.slug}"
    @years = (2010..2014)
  end

  def export
    export_schema

    @years.each { |year| export_year(year) }

    tgz_file_path = "#{@destination_folder}.tgz"
    %x{tar zcvf #{tgz_file_path} #{@destination_folder}}

    FileUtils.rm_rf @destination_folder

    return tgz_file_path
  end

  private

  def export_schema
    dest = "#{@destination_folder}/schemas/"
    FileUtils.rm_rf dest
    FileUtils.mkdir_p dest

    tables = %W{ tb_cuentasEconomica tb_cuentasProgramas tb_inventario tb_funcional tb_economica }

    tables.each do |table_name|
      %x{pg_dump #{database_name} -t \\"#{table_name}_#{@years.first}\\" -s > #{dest}/#{table_name}.sql}
    end

    # load_schema.sh
    fd = File.open("#{dest}load_schema.sh", 'w+')
    fd.write(<<-FILE)
DB=gobify_#{@ine_place.slug}_development
createdb $DB

psql $DB < tb_cuentasEconomica.sql
psql $DB < tb_cuentasProgramas.sql
psql $DB < tb_economica.sql
psql $DB < tb_funcional.sql
psql $DB < tb_inventario.sql

psql -c "ALTER TABLE \\"tb_cuentasEconomica_#{@years.first}\\" RENAME TO \\"tb_cuentasEconomica\\"" $DB
psql -c "ALTER TABLE \\"tb_cuentasEconomica\\" ADD COLUMN year smallint" $DB
psql -c "ALTER TABLE \\"tb_cuentasProgramas_#{@years.first}\\" RENAME TO \\"tb_cuentasProgramas\\"" $DB
psql -c "ALTER TABLE \\"tb_cuentasProgramas\\" ADD COLUMN year smallint" $DB
psql -c "ALTER TABLE \\"tb_economica_#{@years.first}\\" RENAME TO \\"tb_economica\\"" $DB
psql -c "ALTER TABLE \\"tb_economica\\" ADD COLUMN year smallint" $DB
psql -c "ALTER TABLE \\"tb_funcional_#{@years.first}\\" RENAME TO \\"tb_funcional\\"" $DB
psql -c "ALTER TABLE \\"tb_funcional\\" ADD COLUMN year smallint" $DB
psql -c "ALTER TABLE \\"tb_inventario_#{@years.first}\\" RENAME TO \\"tb_inventario\\"" $DB
psql -c "ALTER TABLE \\"tb_inventario\\" ADD COLUMN year smallint" $DB
FILE
    fd.close

    FileUtils.chmod "u=wrx", "#{dest}load_schema.sh"
  end

  def export_year(year)
    dest = "#{@destination_folder}/#{year}/"

    FileUtils.rm_rf dest
    FileUtils.mkdir_p dest

    # tb_cuentasEconomica
    connection.execute %Q{COPY (SELECT *, #{year} as year FROM "tb_cuentasEconomica_#{year}") TO '#{dest}tb_cuentasEconomica.csv' DELIMITER ',' CSV HEADER;}

    # tb_cuentasProgramas
    connection.execute %Q{COPY (SELECT *, #{year} as year FROM "tb_cuentasProgramas_#{year}") TO '#{dest}tb_cuentasProgramas.csv' DELIMITER ',' CSV HEADER;}

    # tb_inventario
    puts "NAME: #{@ine_place.name}"
    puts "codente: #{codente}"
    puts "year: #{year}"
    connection.execute %Q{COPY (SELECT *, #{year} as year FROM tb_inventario_#{year} WHERE codente = '#{codente}') TO '#{dest}tb_inventario.csv' DELIMITER ',' CSV HEADER;}
    query_result = connection.execute("SELECT * FROM tb_inventario_#{year} WHERE codente = '#{codente}'").first
    if query_result
      id = query_result['id']
      puts "id: #{id}"

      # tb_funcional
      connection.execute %Q{COPY (SELECT *, #{year} as year FROM tb_funcional_#{year} WHERE id = '#{id}') TO '#{dest}tb_funcional.csv' DELIMITER ',' CSV HEADER;}

      # tb_economica
      connection.execute %Q{COPY (SELECT *, #{year} as year FROM tb_economica_#{year} WHERE id = '#{id}') TO '#{dest}tb_economica.csv' DELIMITER ',' CSV HEADER;}

      # load_data.sh
      fd = File.open("#{dest}load_data.sh", 'w+')
      fd.write(<<-FILE)
  DB=gobify_#{@ine_place.slug}_development

  psql -c "COPY \\"tb_cuentasEconomica\\" FROM '`pwd`/tb_cuentasEconomica.csv' DELIMITER ',' CSV HEADER;" $DB
  psql -c "COPY \\"tb_cuentasProgramas\\" FROM '`pwd`/tb_cuentasProgramas.csv' DELIMITER ',' CSV HEADER;" $DB
  psql -c "COPY \\"tb_inventario\\"       FROM '`pwd`/tb_inventario.csv'       DELIMITER ',' CSV HEADER;" $DB
  psql -c "COPY \\"tb_funcional\\"        FROM '`pwd`/tb_funcional.csv'        DELIMITER ',' CSV HEADER;" $DB
  psql -c "COPY \\"tb_economica\\"        FROM '`pwd`/tb_economica.csv'        DELIMITER ',' CSV HEADER;" $DB

  FILE
      fd.close

      FileUtils.chmod "u=wrx", "#{dest}load_data.sh"
      puts
      puts "=============================================="
      puts "Database dumped to #{dest}..."
      puts "=============================================="
      puts
    else
      puts
      puts "=============================================="
      puts "There's no data for #{year}"
      puts "=============================================="
      puts
      FileUtils.rm_rf dest
    end
  end

  def codente
    "#{@ine_place.id}AA000"
  end

  def connection
    @connection ||= ActiveRecord::Base.connection
  end

  def database_name
    @database_name ||= ActiveRecord::Base.configurations[Rails.env]['database']
  end
end

