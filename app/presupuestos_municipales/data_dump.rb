class PresupuestosMunicipales::DataDump
  DB_NAME = 'presupuestos_municipales'

  def initialize(year, ine_place)
    @year = year
    @ine_place = ine_place
  end

  def dump
    directory = "/tmp/#{DB_NAME}_#{@year}_#{@ine_place.id}/"
    FileUtils.rm_r directory
    FileUtils.mkdir directory

    FileUtils.cp "./data/#{DB_NAME}/#{@year}/data_clean.sql", directory
    FileUtils.cp "./data/#{DB_NAME}/#{@year}/tb_cuentasEconomica.sql", directory
    FileUtils.cp "./data/#{DB_NAME}/#{@year}/tb_cuentasProgramas.sql", directory

    ar = ActiveRecord::Base.establish_connection(
      adapter:  'postgresql',
      host:     'localhost',
      username: 'fernando',
      password: '',
      database: database_name
    )

    # tb_inventario
    ar.connection.execute %Q{COPY (SELECT * FROM tb_inventario WHERE codente = '#{codente}') TO '#{directory}tb_inventario.csv' DELIMITER ',' CSV HEADER;}

    id = ar.connection.execute("SELECT * FROM tb_inventario WHERE codente = '#{codente}'").first['id']

    # tb_funcional
    ar.connection.execute %Q{COPY (SELECT * FROM tb_funcional WHERE id = '#{id}') TO '#{directory}tb_funcional.csv' DELIMITER ',' CSV HEADER;}

    # tb_economica
    ar.connection.execute %Q{COPY (SELECT * FROM tb_economica WHERE id = '#{id}') TO '#{directory}tb_economica.csv' DELIMITER ',' CSV HEADER;}

    %W{ tb_inventario tb_funcional tb_economica }.each do |table_name|
      %x{pg_dump #{database_name} -t #{table_name} -s > #{directory}/#{table_name}.sql}
    end

    # load_data.sh
    fd = File.open("#{directory}load_data.sh", 'w+')
    fd.write(<<-FILE)
DB=presupuestos_municipales_2014_#{@ine_place.id}_development

dropdb $DB
createdb $DB

psql $DB < tb_cuentasEconomica.sql
psql $DB < tb_cuentasProgramas.sql
psql $DB < tb_economica.sql
psql $DB < tb_funcional.sql
psql $DB < tb_inventario.sql
psql $DB < data_clean.sql

psql -c "COPY tb_inventario FROM '#{directory}tb_inventario.csv' DELIMITER ',' CSV HEADER;" $DB
psql -c "COPY tb_funcional FROM '#{directory}tb_funcional.csv' DELIMITER ',' CSV HEADER;" $DB
psql -c "COPY tb_economica FROM '#{directory}tb_economica.csv' DELIMITER ',' CSV HEADER;" $DB
FILE
    fd.close

    FileUtils.chmod "u=wrx", "#{directory}load_data.sh"
    puts "Database dumped to #{directory}..."
  end

  private

  def codente
    "#{@ine_place.id}AA000"
  end

  def database_name
    "#{DB_NAME}_#{@year}"
  end
end
