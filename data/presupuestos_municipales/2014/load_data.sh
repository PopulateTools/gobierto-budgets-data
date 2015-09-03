DB=presupuestos_municipales_2014

createdb $DB

echo 'Loading tb_cuentasEconomica.sql...'
psql $DB < tb_cuentasEconomica.sql

echo 'Loading tb_cuentasProgramas.sql...'
psql $DB < tb_cuentasProgramas.sql

echo 'Loading tb_economica.sql...'
psql $DB < tb_economica.sql

echo 'Loading tb_funcional.sql...'
psql $DB < tb_funcional.sql

echo 'Loading tb_inventario.sql...'
psql $DB < tb_inventario.sql

echo 'Cleaning the data...'
psql $DB < data_clean.sql
