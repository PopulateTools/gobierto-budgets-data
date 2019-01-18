# Gobierto budgets data

This repository contains the data and the scripts needed to load the municipalities data from Spain
into a Postgres database. The data is from years 2010 to 2016 and includes planned and executed.

**Important**: the data contained in this repository has been updated on 02/07/2018.

## How to load the data

### Setup

1 - Install Ruby 2.6.0

2 - Create a file `config/database.yml`. You can base it on `config/database.yml.example`

3 - Run `bundle install`

4 - Create two databases, one for planned data, and other for executed data. In postgres you can
do it using `createdb`. Example:
  - `createdb budgets-planned`
  - `createdb budgets-executed`

5 - Run the script:
  - To load the planned data: `$ bin/rails runner import.rb budgets-planned planned`
  - To load the executed data: `$ bin/rails runner import.rb budgets-executed executed`

## Understanding the data

_Ministerio de Hacienda y Administraciones Públicas_ publishes in their website [the data](http://serviciostelematicosext.minhap.gob.es/SGCAL/entidadeslocales/) of municipalities budgets, both the planned budget and the executed one. They have a couple of methodology notes in case you are interested in: [Nota Metodológica](http://www.minhap.gob.es/Documentacion/Publico/DGCFEL/InstruccionesAplicaciones/NOTA%20METODOL%C3%93GICA.Presupuestos%20y%20Liquidaciones.pdf) and [Metodología Base de datos Access](http://serviciosweb.meh.es/apps/EntidadesLocales/publicaciones/eell/Metodolog%C3%ADa%20base%20de%20Datos%20Access.doc).  The data published is in Microsoft Access format.

We, at Gobierto, have followed these steps to convert it to SQL, which is a better format to
distribute the data.

1 - Fetch all the data from 2010 to 2016. There are separated files for each year and for planned
and executed.

2 - Using an external application, we have converted the data to Postgres format.

3 - We have put each SQL file, compressed in GZip format, into a folder in
`data/presupuestos_municipales` with the name of the yar. There are two sub-folders named
`executed/` and `planned/`.

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

Gobierto, 2018
