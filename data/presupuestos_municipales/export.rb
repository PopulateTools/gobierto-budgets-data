(2010..2014).each do |year|
  PresupuestosMunicipales::DataExport.new(year, INE::Place.find_by_name('Burjassot')).export
end
