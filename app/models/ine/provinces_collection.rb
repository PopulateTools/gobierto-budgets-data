class INE::ProvincesCollection
  include Singleton

  def self.records
    @records ||= begin
               CSV.read("data/ine/provincias.csv").map do |raw_data|
                 build_from_raw_data(raw_data)
               end.sort_by(&:slug)
             end
  end

  def self.build_from_raw_data(raw_data)
    autonomous_regions = INE::AutonomousRegionsCollection.records

    INE::Province.new({
      id: raw_data[0], name: raw_data[2],
      slug: raw_data[3], autonomous_region_id: raw_data[1],
      autonomous_region: autonomous_regions.detect{|a| a.id == raw_data[1] },
      lon: raw_data[4], lat: raw_data[5]
    })
  end
end
