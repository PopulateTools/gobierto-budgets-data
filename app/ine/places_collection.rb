class INE::PlacesCollection
  include Singleton

  def self.records
    @records ||= begin
               CSV.read("data/ine/municipios.csv", headers: true).map do |raw_data|
                 build_from_raw_data(raw_data)
               end.sort_by(&:slug)
             end
  end

  def self.build_from_raw_data(raw_data)
    provinces = INE::ProvincesCollection.records

    INE::Place.new({
      id: raw_data[0], name: raw_data[2],
      slug: raw_data[3], province_id: raw_data[1],
      province: provinces.detect{|p| p.id == raw_data[1] },
      lon: raw_data[6], lat: raw_data[7]
    })
  end
end
