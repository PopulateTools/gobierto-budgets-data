file = PresupuestosMunicipales::DataExport.new(INE::Place.find_by_name('Gijón')).export
puts file
