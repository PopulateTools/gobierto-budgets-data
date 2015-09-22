class PresupuestosMunicipales::DataExport
  def initialize(ine_place)
    @ine_place = ine_place
    @destination_folder = "/tmp/presupuestos_municipales_#{@ine_place.slug}"
  end

  def export
    (2010..2014).each do |year|
      export_year(year)
    end

    tgz_file_path = "#{@destination_folder}.tgz"
    %x{tar zcvf #{tgz_file_path} #{@destination_folder}}

    FileUtils.rm_rf @destination_folder

    return tgz_file_path
  end

  private

  def export_year(year)
    dest = "#{@destination_folder}/#{year}/"
    database_name = ActiveRecord::Base.configurations[Rails.env]['database']
    tables = %W{ tb_cuentasEconomica tb_cuentasProgramas tb_inventario tb_funcional tb_economica }

    FileUtils.rm_rf dest
    FileUtils.mkdir_p dest

    # tb_cuentasEconomica
    connection.execute %Q{COPY (SELECT * FROM "tb_cuentasEconomica_#{year}") TO '#{dest}tb_cuentasEconomica.csv' DELIMITER ',' CSV HEADER;}

    # tb_cuentasProgramas
    connection.execute %Q{COPY (SELECT * FROM "tb_cuentasProgramas_#{year}") TO '#{dest}tb_cuentasProgramas.csv' DELIMITER ',' CSV HEADER;}

    # tb_inventario
    connection.execute %Q{COPY (SELECT * FROM tb_inventario_#{year} WHERE codente = '#{codente}') TO '#{dest}tb_inventario.csv' DELIMITER ',' CSV HEADER;}
    id = connection.execute("SELECT * FROM tb_inventario_#{year} WHERE codente = '#{codente}'").first['id']

    # tb_funcional
    connection.execute %Q{COPY (SELECT * FROM tb_funcional_#{year} WHERE id = '#{id}') TO '#{dest}tb_funcional.csv' DELIMITER ',' CSV HEADER;}

    # tb_economica
    connection.execute %Q{COPY (SELECT * FROM tb_economica_#{year} WHERE id = '#{id}') TO '#{dest}tb_economica.csv' DELIMITER ',' CSV HEADER;}

    tables.each do |table_name|
      puts table_name
      %x{pg_dump #{database_name} -t \\"#{table_name}_#{year}\\" -s | gzip > #{dest}/#{table_name}.sql.gz}
    end

    # load_data.sh
    fd = File.open("#{dest}load_data.sh", 'w+')
    fd.write(<<-FILE)
DB=gobify_#{@ine_place.slug}_development
createdb $DB

gzip -d *.gz

psql $DB < tb_cuentasEconomica.sql
psql $DB < tb_cuentasProgramas.sql
psql $DB < tb_economica.sql
psql $DB < tb_funcional.sql
psql $DB < tb_inventario.sql

psql -c "COPY \\"tb_cuentasEconomica_#{year}\\" FROM '`pwd`/tb_cuentasEconomica.csv' DELIMITER ',' CSV HEADER;" $DB
psql -c "COPY \\"tb_cuentasProgramas_#{year}\\" FROM '`pwd`/tb_cuentasProgramas.csv' DELIMITER ',' CSV HEADER;" $DB
psql -c "COPY \\"tb_inventario_#{year}\\"       FROM '`pwd`/tb_inventario.csv'       DELIMITER ',' CSV HEADER;" $DB
psql -c "COPY \\"tb_funcional_#{year}\\"        FROM '`pwd`/tb_funcional.csv'        DELIMITER ',' CSV HEADER;" $DB
psql -c "COPY \\"tb_economica_#{year}\\"        FROM '`pwd`/tb_economica.csv'        DELIMITER ',' CSV HEADER;" $DB

FILE
    fd.close

    FileUtils.chmod "u=wrx", "#{dest}load_data.sh"
    puts
    puts "=============================================="
    puts "Database dumped to #{dest}..."
    puts "=============================================="
    puts
  end

  def codente
    "#{@ine_place.id}AA000"
  end

  def connection
    @connection ||= ActiveRecord::Base.connection
  end
end

