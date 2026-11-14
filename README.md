# Gobierto budgets data

This repository contains the data and the scripts needed to load the municipalities data from Spain
into a Postgres database. The data is from years 2010 to 2025 and includes planned (2010-2025) and
executed (2010-2024).

## How to load the data

### Setup

1 - Install the dependencies: `brew bundle` on macOS (see `Brewfile`), or `apt install mdbtools
postgresql-client` on Debian/Ubuntu.

2 - Create two databases, one for planned data, and other for executed data:
  - `createdb budgets-planned`
  - `createdb budgets-executed`

The scripts connect with `psql`, so they use the standard `PGHOST`, `PGPORT`, `PGUSER` and
`PGPASSWORD` environment variables. `bin/import` reads them from a `.env` file in the repository root
when it exists. The database argument can also be a connection URL.

### Import

  - Planned data: `bin/import budgets-planned planned`
  - Executed data: `bin/import budgets-executed executed`
  - A single year: `bin/import budgets-planned planned 2025`

Each file is loaded in its own transaction with `COPY`, so a full load takes a couple of minutes.
Tables get indexes on `idente` and `codente`, the columns Gobierto uses to read one entity at a
time.

### Add or update a year

_Ministerio de Hacienda_ publishes each year as a ZIP with a Microsoft Access database, separately
for planned budgets (_Presupuestos_, e.g. `Presupuestos2025.zip`) and executed budgets
(_Liquidaciones_). Years are sometimes republished with more entities, so the same year can be
converted again.

    bin/convert ~/Desktop/Presupuestos2025.zip 2025 planned

`bin/convert` reads the Access database with [mdbtools](https://github.com/mdbtools/mdbtools),
replaces the files in `data/presupuestos_municipales/<year>/<planned|executed>/` and uses a
temporary Postgres database as scratch space. Then load the year with `bin/import` and commit the
new files.

### Report

`bin/report budgets-planned` writes `docs/<year>.md` with the municipalities without a budget in
each year. It needs Ruby and installs its gems on the first run.

## Understanding the data

_Ministerio de Hacienda y Administraciones Públicas_ publishes in their website [the data](https://serviciostelematicosext.hacienda.gob.es/SGFAL/CONPREL) of municipalities budgets, both the planned budget and the executed one. They have a couple of methodology notes in case you are interested in: [Nota Metodológica](https://serviciostelematicosext.hacienda.gob.es/SGCAL/CONPREL/Consulta/DescargaFichero?CCAA=&TipoDato=Presupuestos&Ejercicio=2019&TipoPublicacion=Access) and [Metodología Base de datos Access](https://serviciostelematicosext.hacienda.gob.es/SGCAL/CONPREL/Consulta/DescargaFicheroMetodologico?idFichero=809).  The data published is in Microsoft Access format.

We convert each Access database to SQL with `bin/convert`, which is a better format to distribute
the data. Each table is stored as a gzipped SQL file with a `CREATE TABLE` and a `COPY` block, in
`data/presupuestos_municipales/<year>/<planned|executed>/`. Leading and trailing spaces in text
columns are removed during the conversion. Every file can also be loaded with plain `psql`.

There are five main tables. We are not going to describe them completely, but if you want a deeper
description we recommend you to read the documentation mentioned above.

- `tb_inventario`: an inventory table with the list of local entities. An entity can be the
  municipality itself and other local institutions depending on it. When we import the data, we
  aggregate all those sub-budgets into the municipality.

- `tb_funcional`: budgeting data organized using the functional classifcation. In the functional
  classification there are only expenses and not income.

- `tb_cuentasProgramas`: list of functional categories the budgets are organized.

- `tb_economica`: budgeting data organized using the functional classifcation. This classification
  includes both expenses and income.

- `tb_cuentasEconomica`: list of economic categories the budgets are organized.

Both planned and executed data contain the same structure. At the end of the import you should have the following tables in both databases:

```
budgets-executed=# \d
                  List of relations
 Schema |           Name           | Type  |  Owner
--------+--------------------------+-------+----------
 public | tb_cuentasEconomica_2010 | table | wadus
 public | tb_cuentasEconomica_2011 | table | wadus
 public | tb_cuentasEconomica_2012 | table | wadus
 public | tb_cuentasEconomica_2013 | table | wadus
 public | tb_cuentasEconomica_2014 | table | wadus
 public | tb_cuentasProgramas_2010 | table | wadus
 public | tb_cuentasProgramas_2011 | table | wadus
 public | tb_cuentasProgramas_2012 | table | wadus
 public | tb_cuentasProgramas_2013 | table | wadus
 public | tb_cuentasProgramas_2014 | table | wadus
 public | tb_cuentasRemanente_2010 | table | wadus
 public | tb_cuentasRemanente_2011 | table | wadus
 public | tb_cuentasRemanente_2012 | table | wadus
 public | tb_cuentasRemanente_2013 | table | wadus
 public | tb_cuentasRemanente_2014 | table | wadus
 public | tb_economica_2010        | table | wadus
 public | tb_economica_2011        | table | wadus
 public | tb_economica_2012        | table | wadus
 public | tb_economica_2013        | table | wadus
 public | tb_economica_2014        | table | wadus
 public | tb_funcional_2010        | table | wadus
 public | tb_funcional_2011        | table | wadus
 public | tb_funcional_2012        | table | wadus
 public | tb_funcional_2013        | table | wadus
 public | tb_funcional_2014        | table | wadus
 public | tb_inventario_2010       | table | wadus
 public | tb_inventario_2011       | table | wadus
 public | tb_inventario_2012       | table | wadus
 public | tb_inventario_2013       | table | wadus
 public | tb_inventario_2014       | table | wadus
```

## Suggestions

Please, contact us at `fernando@populate.tools`.

## Contributing

Follow the regular steps: create and issue, or suggest a change with a PR.

## Credits

Gobierto, 2020
