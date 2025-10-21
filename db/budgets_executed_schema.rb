# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 0) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "tb_cuentasEconomica_2010", id: false, force: :cascade do |t|
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasEconomica_2011", id: false, force: :cascade do |t|
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasEconomica_2012", id: false, force: :cascade do |t|
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasEconomica_2013", id: false, force: :cascade do |t|
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasEconomica_2014", id: false, force: :cascade do |t|
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasEconomica_2015", id: false, force: :cascade do |t|
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasEconomica_2016", id: false, force: :cascade do |t|
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasEconomica_2017", id: false, force: :cascade do |t|
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasEconomica_2018", id: false, force: :cascade do |t|
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasEconomica_2019", id: false, force: :cascade do |t|
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasEconomica_2020", id: false, force: :cascade do |t|
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasEconomica_2021", id: false, force: :cascade do |t|
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasEconomica_2022", id: false, force: :cascade do |t|
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasProgramas_2010", id: false, force: :cascade do |t|
    t.string "cdfgr", limit: 3
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasProgramas_2011", id: false, force: :cascade do |t|
    t.string "cdfgr", limit: 3
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasProgramas_2012", id: false, force: :cascade do |t|
    t.string "cdfgr", limit: 3
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasProgramas_2013", id: false, force: :cascade do |t|
    t.string "cdfgr", limit: 3
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasProgramas_2014", id: false, force: :cascade do |t|
    t.string "cdfgr", limit: 3
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasProgramas_2015", id: false, force: :cascade do |t|
    t.string "cdfgr", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasProgramas_2016", id: false, force: :cascade do |t|
    t.string "cdfgr", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasProgramas_2017", id: false, force: :cascade do |t|
    t.string "cdfgr", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasProgramas_2018", id: false, force: :cascade do |t|
    t.string "cdfgr", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasProgramas_2019", id: false, force: :cascade do |t|
    t.string "cdfgr", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasProgramas_2020", id: false, force: :cascade do |t|
    t.string "cdfgr", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasProgramas_2021", id: false, force: :cascade do |t|
    t.string "cdfgr", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasProgramas_2022", id: false, force: :cascade do |t|
    t.string "cdfgr", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasRemanente_2010", id: false, force: :cascade do |t|
    t.string "cdrmte", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasRemanente_2011", id: false, force: :cascade do |t|
    t.string "cdrmte", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasRemanente_2012", id: false, force: :cascade do |t|
    t.string "cdrmte", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasRemanente_2013", id: false, force: :cascade do |t|
    t.string "cdrmte", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasRemanente_2014", id: false, force: :cascade do |t|
    t.string "cdrmte", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasRemanente_2015", id: false, force: :cascade do |t|
    t.string "cdrmte", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasRemanente_2018", id: false, force: :cascade do |t|
    t.string "cdrmte", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasRemanente_2019", id: false, force: :cascade do |t|
    t.string "cdrmte", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasRemanente_2020", id: false, force: :cascade do |t|
    t.string "cdrmte", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_cuentasRemanente_2022", id: false, force: :cascade do |t|
    t.string "cdrmte", limit: 6
    t.string "nombre", limit: 125
  end

  create_table "tb_economica_2010", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importer", precision: 15, scale: 2
    t.decimal "imported", precision: 15, scale: 2
    t.decimal "importel", precision: 15, scale: 2
    t.decimal "importec", precision: 15, scale: 2
  end

  create_table "tb_economica_2011", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importer", precision: 15, scale: 2
    t.decimal "imported", precision: 15, scale: 2
    t.decimal "importel", precision: 15, scale: 2
    t.decimal "importec", precision: 15, scale: 2
  end

  create_table "tb_economica_2012", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_2013", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_2014", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_2015", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_2016", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_2017", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_2018", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_2019", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_2020", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "imported", precision: 15, scale: 2
    t.decimal "importer", precision: 15, scale: 2
    t.decimal "importel", precision: 15, scale: 2
    t.decimal "importec", precision: 15, scale: 2
  end

  create_table "tb_economica_2021", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_2022", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "imported", precision: 15, scale: 2
    t.decimal "importer", precision: 15, scale: 2
    t.decimal "importel", precision: 15, scale: 2
    t.decimal "importec", precision: 15, scale: 2
  end

  create_table "tb_economica_cons_2012", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_cons_2013", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_cons_2014", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_cons_2015", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_cons_2016", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_cons_2017", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_cons_2018", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_cons_2019", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_cons_2020", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "imported", precision: 15, scale: 2
    t.decimal "importer", precision: 15, scale: 2
    t.decimal "importel", precision: 15, scale: 2
    t.decimal "importec", precision: 15, scale: 2
  end

  create_table "tb_economica_cons_2021", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_economica_cons_2022", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "tipreig", limit: 1
    t.string "cdcta", limit: 6
    t.decimal "imported", precision: 15, scale: 2
    t.decimal "importer", precision: 15, scale: 2
    t.decimal "importel", precision: 15, scale: 2
    t.decimal "importec", precision: 15, scale: 2
  end

  create_table "tb_funcional_2010", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 3
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_2011", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 3
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_2012", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 3
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_2013", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 3
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_2014", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 3
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_2015", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_2016", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_2017", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_2018", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_2019", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_2020", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_2021", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_2022", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_cons_2012", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 3
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_cons_2013", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 3
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_cons_2014", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 3
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_cons_2015", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_cons_2016", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_cons_2017", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_cons_2018", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_cons_2019", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_cons_2020", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_cons_2021", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_funcional_cons_2022", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "cdcta", limit: 6
    t.string "cdfgr", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_inventario_2010", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "codbdgel", limit: 10
    t.string "nombreppal", limit: 70
    t.decimal "idente", precision: 15, scale: 2
    t.string "codente", limit: 10
    t.string "nombreente", limit: 70
    t.decimal "nsec", precision: 15, scale: 2
    t.decimal "poblacion", precision: 15, scale: 2
    t.string "estado", limit: 1
  end

  create_table "tb_inventario_2011", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "codbdgel", limit: 10
    t.string "nombreppal", limit: 70
    t.decimal "idente", precision: 15, scale: 2
    t.string "codente", limit: 10
    t.string "nombreente", limit: 70
    t.decimal "nsec", precision: 15, scale: 2
    t.decimal "poblacion", precision: 15, scale: 2
    t.string "estado", limit: 1
  end

  create_table "tb_inventario_2012", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "codbdgel", limit: 10
    t.string "nombreppal", limit: 70
    t.decimal "idente", precision: 15, scale: 2
    t.string "codente", limit: 10
    t.string "nombreente", limit: 70
    t.decimal "nsec", precision: 15, scale: 2
    t.decimal "poblacion", precision: 15, scale: 2
    t.string "estado", limit: 1
  end

  create_table "tb_inventario_2013", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "codbdgel", limit: 10
    t.string "nombreppal", limit: 70
    t.decimal "idente", precision: 15, scale: 2
    t.string "codente", limit: 10
    t.string "nombreente", limit: 70
    t.decimal "nsec", precision: 15, scale: 2
    t.decimal "poblacion", precision: 15, scale: 2
    t.string "estado", limit: 1
  end

  create_table "tb_inventario_2014", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "codbdgel", limit: 10
    t.string "nombreppal", limit: 70
    t.decimal "idente", precision: 15, scale: 2
    t.string "codente", limit: 10
    t.string "nombreente", limit: 70
    t.decimal "nsec", precision: 15, scale: 2
    t.decimal "poblacion", precision: 15, scale: 2
    t.string "estado", limit: 1
  end

  create_table "tb_inventario_2015", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "codbdgel", limit: 10
    t.string "nombreppal", limit: 70
    t.decimal "idente", precision: 15, scale: 2
    t.string "codente", limit: 10
    t.string "nombreente", limit: 70
    t.decimal "nsec", precision: 15, scale: 2
    t.decimal "poblacion", precision: 15, scale: 2
    t.string "estado", limit: 1
  end

  create_table "tb_inventario_2016", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "codbdgel", limit: 10
    t.string "nombreppal", limit: 70
    t.decimal "idente", precision: 15, scale: 2
    t.string "codente", limit: 10
    t.string "nombreente", limit: 70
    t.decimal "nsec", precision: 15, scale: 2
    t.decimal "poblacion", precision: 15, scale: 2
    t.string "estado", limit: 1
  end

  create_table "tb_inventario_2017", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "codbdgel", limit: 10
    t.string "nombreppal", limit: 70
    t.decimal "idente", precision: 15, scale: 2
    t.string "codente", limit: 10
    t.string "nombreente", limit: 70
    t.decimal "nsec", precision: 15, scale: 2
    t.decimal "poblacion", precision: 15, scale: 2
    t.string "estado", limit: 1
  end

  create_table "tb_inventario_2018", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "codbdgel", limit: 10
    t.string "nombreppal", limit: 70
    t.decimal "idente", precision: 15, scale: 2
    t.string "codente", limit: 10
    t.string "nombreente", limit: 70
    t.decimal "nsec", precision: 15, scale: 2
    t.decimal "poblacion", precision: 15, scale: 2
    t.string "estado", limit: 1
  end

  create_table "tb_inventario_2019", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "codbdgel", limit: 10
    t.string "nombreppal", limit: 70
    t.decimal "idente", precision: 15, scale: 2
    t.string "codente", limit: 10
    t.string "nombreente", limit: 70
    t.decimal "nsec", precision: 15, scale: 2
    t.decimal "poblacion", precision: 15, scale: 2
    t.string "estado", limit: 1
  end

  create_table "tb_inventario_2020", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "codbdgel", limit: 10
    t.string "nombreppal", limit: 70
    t.decimal "idente", precision: 15, scale: 2
    t.string "codente", limit: 10
    t.string "nombreente", limit: 70
    t.decimal "nsec", precision: 15, scale: 2
    t.decimal "poblacion", precision: 15, scale: 2
    t.string "estado", limit: 1
  end

  create_table "tb_inventario_2021", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "codbdgel", limit: 10
    t.string "nombreppal", limit: 70
    t.decimal "idente", precision: 15, scale: 2
    t.string "codente", limit: 10
    t.string "nombreente", limit: 70
    t.decimal "nsec", precision: 15, scale: 2
    t.decimal "poblacion", precision: 15, scale: 2
    t.string "estado", limit: 1
  end

  create_table "tb_inventario_2022", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.string "codbdgel", limit: 10
    t.string "nombreppal", limit: 70
    t.decimal "idente", precision: 15, scale: 2
    t.string "codente", limit: 10
    t.string "nombreente", limit: 70
    t.decimal "nsec", precision: 15, scale: 2
    t.decimal "poblacion", precision: 15, scale: 2
    t.string "estado", limit: 1
  end

  create_table "tb_remanente_2010", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdrmte", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_remanente_2011", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdrmte", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_remanente_2012", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdrmte", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_remanente_2013", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdrmte", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_remanente_2014", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdrmte", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_remanente_2015", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdrmte", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_remanente_2020", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdrmte", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end

  create_table "tb_remanente_2022", id: false, force: :cascade do |t|
    t.decimal "id", precision: 15, scale: 2
    t.decimal "idente", precision: 15, scale: 2
    t.string "cdrmte", limit: 6
    t.decimal "importe", precision: 15, scale: 2
  end
end
