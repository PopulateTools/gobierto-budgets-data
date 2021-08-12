if ARGV.length != 2 && ARGV.length != 3
  puts "Missing parameters. Usage: rails runner import.rb <database name> <area name: planned | executed> <year: optional>"
  puts
  puts "Example: "
  puts "    rails runner import.rb budgets-planned planned [2021]"
  puts

  exit -1
end

database = ARGV[0].strip
what = ARGV[1].strip
year = ARGV[2].strip

importer = DataImport.new(database, what, year)
importer.import_in_database
