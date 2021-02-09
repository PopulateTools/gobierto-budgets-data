require 'ine'
require 'csv'

class Reporter
  def initialize(database)
    raise 'Missing database name' if database.blank?

    @database = database
    population = CSV.read("docs/population.csv", headers: true)
    @population = Hash[population.map{ |r| [r["place_id"].to_i, r["population"].to_i]}]
  end

  def report
    places_ids = INE::Places::Place.all.map(&:id).map(&:to_i).sort
    (2020..2020).each do |year|
      puts "Reporting #{year}"
      found = []
      results = connection.execute("select * from tb_inventario_#{year} where codente like '%AA000'")
      results.each do |result|
        begin
          found << result["codente"].gsub(/(\d+)AA000/, "#{$1}").to_i
        rescue
          puts result["codente"]
        end
      end
      generate_report(year, places_ids, found)
    end
  end

  private

  def connection
    @connection ||= ActiveRecord::Base.establish_connection(
      adapter: 'postgresql',
      database: @database,
      username: ENV["PG_USERNAME"],
      password: ENV["PG_PASSWORD"],
      host: ENV["PG_HOST"]
    ).connection
  end

  def generate_report(year, places_ids, found)
    FileUtils.mkdir_p("docs")
    places = (places_ids - found).map{ |missing_place_id| INE::Places::Place.find(missing_place_id) }
    s = []
    places.group_by(&:province).each do |province, places|
      s << "## #{province.name}"
      places.sort{ |p2, p1| @population[p1.id.to_i] <=> @population[p2.id.to_i] }.each do |place|
        s << "- #{place.name}"
      end
    end
    File.write("docs/#{year}.md", s.join("\n"))
  end
end
