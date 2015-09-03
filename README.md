# Gobify Data

El código en este repositorio es responsable de suministrar a las instancias de Gobify con los datos
necesarios para arrancar la aplicación.

## Datos manejados por Gobify data

### Presupuestos municipales

```ruby

PresupuestosMunicipales::DataDump.new(2014, INE::Place.find_by_name('Gijón')).dump

```
