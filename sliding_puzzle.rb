require 'ruby-prof'
require_relative 'lib/grid'
require_relative 'lib/relaxed_grid'
require_relative 'lib/pattern_database'
require 'pry'
require 'benchmark' 

#{name: "01", challenge: [[1,0,2],[3,4,5],[6,7,8]]},
challenges = [	
	{name: "01", challenge: [[1,0,2],[3,4,5],[6,7,8]]},
	{name: "02", challenge: [[1,2,0],[3,4,5],[6,7,8]]},
	{name: "03", challenge: [[1,2,5],[3,4,0],[6,7,8]]},
	{name: "04", challenge: [[1,2,5],[3,4,8],[6,7,0]]},
	{name: "05", challenge: [[1,2,5],[3,4,8],[6,0,7]]},
	{name: "06", challenge: [[1,2,5],[3,0,8],[6,4,7]]},
	{name: "07", challenge: [[1,2,5],[0,3,8],[6,4,7]]},
	{name: "08", challenge: [[0,2,5],[1,3,8],[6,4,7]]},
	{name: "09", challenge: [[2,0,5],[1,3,8],[6,4,7]]},
	{name: "10", challenge: [[2,3,5],[1,0,8],[6,4,7]]},
	{name: "11", challenge: [[2,3,5],[1,8,0],[6,4,7]]},
	{name: "12", challenge: [[2,3,5],[1,8,7],[6,4,0]]},
	{name: "13", challenge: [[2,3,5],[1,8,7],[6,0,4]]},
	{name: "14", challenge: [[2,3,5],[1,8,7],[0,6,4]]},
	{name: "15", challenge: [[2,3,5],[0,8,7],[1,6,4]]}

]


challenges.each do |ch|
	puts "============ Challenge - #{ch[:name]} ===================="
	puts ""
	puzzle = SlidingPuzzle::Grid.new ch[:challenge]
	puzzle2 = SlidingPuzzle::Grid.new ch[:challenge]
	puzzle.train_pattern
	puzzle2.train_pattern
	x, y = nil
	Benchmark.bm do |r|
	  r.report("MD") { x = puzzle.solve(:manhattan_distance); nil }
	  r.report("PDB") { y = puzzle2.solve(:pattern_database); nil }
	end
	puts x
	puts y
	puts ""
end



#printer = RubyProf::GraphPrinter.new(result)
#printer.print(STDOUT, {})
