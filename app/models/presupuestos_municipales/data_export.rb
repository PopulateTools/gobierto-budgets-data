class PresupuestosMunicipales::DataExport
  def initialize(year, ine_place)
    @year = year
    @ine_place = ine_place
  end

  def export
    dest = "/tmp/presupuestos_municipales_#{@year}_#{@ine_place.id}/"
    database_name = ActiveRecord::Base.configurations[Rails.env]['database']
    tables = %W{ tb_cuentasEconomica tb_cuentasProgramas tb_inventario tb_funcional tb_economica }

    FileUtils.rm_rf dest
    FileUtils.mkdir dest

    # tb_cuentasEconomica
    connection.execute %Q{COPY (SELECT * FROM "tb_cuentasEconomica_#{@year}") TO '#{dest}tb_cuentasEconomica.csv' DELIMITER ',' CSV HEADER;}

    # tb_cuentasProgramas
    connection.execute %Q{COPY (SELECT * FROM "tb_cuentasProgramas_#{@year}") TO '#{dest}tb_cuentasProgramas.csv' DELIMITER ',' CSV HEADER;}

    # tb_inventario
    connection.execute %Q{COPY (SELECT * FROM tb_inventario_#{@year} WHERE codente = '#{codente}') TO '#{dest}tb_inventario.csv' DELIMITER ',' CSV HEADER;}
    id = connection.execute("SELECT * FROM tb_inventario_#{@year} WHERE codente = '#{codente}'").first['id']

    # tb_funcional
    connection.execute %Q{COPY (SELECT * FROM tb_funcional_#{@year} WHERE id = '#{id}') TO '#{dest}tb_funcional.csv' DELIMITER ',' CSV HEADER;}

    # tb_economica
    connection.execute %Q{COPY (SELECT * FROM tb_economica_#{@year} WHERE id = '#{id}') TO '#{dest}tb_economica.csv' DELIMITER ',' CSV HEADER;}

    tables.each do |table_name|
      puts table_name
      %x{pg_dump #{database_name} -t \\"#{table_name}_#{@year}\\" -s | gzip > #{dest}/#{table_name}.sql.gz}
    end

    # load_data.sh
    fd = File.open("#{dest}load_data.sh", 'w+')
    fd.write(<<-FILE)
DB=gobify_development
gzip -d *.gz

psql $DB < tb_cuentasEconomica.sql
psql $DB < tb_cuentasProgramas.sql
psql $DB < tb_economica.sql
psql $DB < tb_funcional.sql
psql $DB < tb_inventario.sql

psql -c "COPY \\"tb_cuentasEconomica_#{@year}\\" FROM '#{dest}tb_cuentasEconomica.csv' DELIMITER ',' CSV HEADER;" $DB
psql -c "COPY \\"tb_cuentasProgramas_#{@year}\\" FROM '#{dest}tb_cuentasProgramas.csv' DELIMITER ',' CSV HEADER;" $DB
psql -c "COPY \\"tb_inventario_#{@year}\\"       FROM '#{dest}tb_inventario.csv'       DELIMITER ',' CSV HEADER;" $DB
psql -c "COPY \\"tb_funcional_#{@year}\\"        FROM '#{dest}tb_funcional.csv'        DELIMITER ',' CSV HEADER;" $DB
psql -c "COPY \\"tb_economica_#{@year}\\"        FROM '#{dest}tb_economica.csv'        DELIMITER ',' CSV HEADER;" $DB

FILE
    fd.close

    FileUtils.chmod "u=wrx", "#{dest}load_data.sh"
    puts
    puts "=============================================="
    puts "Database dumped to #{dest}..."
    puts "=============================================="
    puts
  end

  private

  def codente
    "#{@ine_place.id}AA000"
  end

  def connection
    @connection ||= ActiveRecord::Base.connection
  end
end

