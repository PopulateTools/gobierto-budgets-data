class INE::AutonomousRegion < OpenStruct
  include INE::CSVRecord

  def provinces
    INE::Province.find_all_by_autonomous_region_id(self.id)
  end

  private

  def self.collection_klass
    INE::AutonomousRegionsCollection
  end

  def self.filter(records, name)
    return [] if name.blank?
    parameterized_name = name.parameterize

    records.select{|a| a.slug.include?(parameterized_name) }.
      sort_by{|a| a.name.parameterize }
  end
end
