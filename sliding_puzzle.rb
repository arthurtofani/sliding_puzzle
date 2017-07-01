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
	{name: "15", challenge: [[2,3,5],[0,8,7],[1,6,4]]},
]
 challenges2 = [	{name: "16", challenge: [[0,3,5],[2,8,7],[1,6,4]]},
 	{name: "17", challenge: [[3,0,5],[2,8,7],[1,6,4]]},
 	{name: "18", challenge: [[3,8,5],[2,0,7],[1,6,4]]},
 	{name: "19", challenge: [[3,8,5],[2,7,0],[1,6,4]]},
 	{name: "20", challenge: [[3,8,5],[2,7,4],[1,6,0]]}
 ]
challenges += challenges2

def run(challenges, heuristic, patterns=[], time=120)
	c = []
	puts heuristic
	puts patterns.map{|s| s[:name] rescue ""}.join("+")
	challenges.each do |ch|
		puzzle = SlidingPuzzle::Grid.new ch[:challenge]		
		#puts "fazendo pattern"
		puzzle.compute_pattern(patterns.map{|s| s[:pattern]}) if heuristic!=:manhattan_distance
		#puts "resolvendo #{ch[:name]}"
		begin
			x = puzzle.solve(heuristic, time)
			c.push x.merge(id: ch[:name])
		rescue
			c.push({id: ch[:name], nodes_visited: -1})
			time = 0.01
		end
		res = ([ch[:name], x[:nodes_visited]].to_s rescue "#{ch[:name]}")
		#c.push [ch[:name], x[:nodes_visited]]
	end
	c
end

def render(arr, label)
	#acceptable = arr.select{|s| s[:nodes_visited]==-1}.count<2
	# if !acceptable
	# 	puts "aa"
	# 	return
	# end
	a = ""
	a+= "coordinates {\n"
	arr.each do |s|
		a+= "\% time: #{s[:time]}\n"
		a+= "(#{s[:id]}, #{s[:nodes_enqueued]})\n"
	end
	a+= "};\n"
	a+= "\\addlegendentry{#{label}}\n"	
	puts a
end

patterns = []
#patterns.push({name: "P1", pattern: [[-1,-1,-1],[-1,4,0],[-1,-1,-1]]})
patterns.push({name: "P1", pattern: [[-1,-1,-1],[-1,4,0],[-1,-1,-1]]})
patterns.push({name: "P2", pattern: [[-1,0,2],[-1,-1,-1],[-1, -1, -1]]})
patterns.push({name: "P3", pattern: [[-1,-1,-1],[0,-1,-1],[6,-1,8]]})
patterns.push({name: "P4", pattern: [[-1,-1,-1],[-1,-1,0],[-1,-1,8]]})

t = Time.now
#manhattan = run(challenges, :manhattan_distance)
#Thread.new do 
	#render(manhattan, "MD")
#end
threads = []

patterns.combination(3).each do |comb|	
	t = Thread.new do 
		sleep(1)
		response = run(challenges, :pattern_database, comb)
		name = "PDB+" + comb.map{|s| s[:name]}.join("+")
		render(response, name)
	end
end
# patterns.combination(2).each do |comb|	
# 	t = Thread.new do 
# 		sleep(0.5)
# 		response = run(challenges, :pattern_database, comb)
# 		name = "PDB+" + comb.map{|s| s[:name]}.join("+")
# 		render(response, name)
# 	end
# end
t.abort_on_exception = true
threads << t
puts "Rodando"
loop do
	sleep(5)
end


#render(run(challenges, :pattern_database), "PDB")
#render(run(challenges, :manhattan_distance), "MD")

#run(:pattern_database)