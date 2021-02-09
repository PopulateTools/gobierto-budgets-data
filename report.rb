if ARGV.length != 1
  puts "Missing parameters. Usage: rails runner report.rb <database name>"
  puts
  puts "Example: "
  puts "    rails runner report.rb budgets-planned planned"
  puts

  exit -1
end

database = ARGV[0].strip

Reporter.new(database).report
