class INE::AutonomousRegionsCollection
  include Singleton

  def self.records
    @records ||= begin
               CSV.read("data/ine/ccaa.csv").map do |raw_data|
                 INE::AutonomousRegion.new({
                   id: raw_data.first, name: raw_data.second, slug: raw_data.third,
                   lon: raw_data[3], lat: raw_data[4]
                 })
               end.sort_by(&:slug)
             end
  end
end
