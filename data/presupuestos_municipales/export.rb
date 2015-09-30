['Gijón', 'Órgiva', 'Santiago de Compostela', 'Ciempozuelos', 'Madrid', 'Cartagena'].each do |name|
  file = PresupuestosMunicipales::DataExport.new(INE::Place.find_by_name(name)).export
  puts file
end


