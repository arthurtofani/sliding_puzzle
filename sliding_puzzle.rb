require 'ruby-prof'
require_relative 'lib/grid'
require_relative 'lib/relaxed_grid'
require_relative 'lib/pattern_database'
require 'pry'

puzzle = SlidingPuzzle::Grid.new [[6,4,3],[1,0,2],[8,5,7]]
puzzle.train_pattern
#puzzle = SlidingPuzzle::Grid.new [[1,2,0],[3,4,5],[6,7,8]]
#pattern_database = SlidingPuzzle::PatternDatabase.new [[0,-1,-1],[-1,-1,-1],[-1,-1,8]]
#pattern_database.train


puzzle.solve
result = RubyProf.profile { puzzle.solve }

#printer = RubyProf::GraphPrinter.new(result)
#printer.print(STDOUT, {})
