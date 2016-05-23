if ARGV.length != 2
  puts "Missing parameters. Usage: rails runner import.rb <database name> <area name: planned | executed>"
  puts
  puts "Example: "
  puts "    rails runner import.rb budgets-planned planned"
  puts

  exit -1
end

database = ARGV[0].strip
what = ARGV[1].strip

importer = DataImport.new(database, what)
importer.import_in_database
