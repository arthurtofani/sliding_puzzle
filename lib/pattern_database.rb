require 'unique_permutation'
require 'pry'
class SlidingPuzzle::PatternDatabase

  attr_accessor :target_pattern, :solutions

  def initialize(target_pattern)
    @target_pattern = target_pattern
    @solutions = {}
    @allowed_symbols = (@target_pattern.flatten.uniq - [-1, 0])
  end

  def find_pattern(entry)
    entry.map{|s| ((@allowed_symbols.include? s) ? s : -1)}
  end

  def cost(entry)

    pattern = entry.map{|s| ((@allowed_symbols.include? s) ? s : -1)}
    vl = @solutions[pattern].count rescue 99999
    puts "#{entry} - #{vl}"
    vl
  end

  def train
    # monta a base de soluções para o problema relaxado
    permutations = target_pattern.flatten.unique_permutation
    permutations_count = permutations.count

    permutations.each_with_index do |permutation, idx|
      next if idx==0
      perm = permutation.each_slice(3).to_a
      puts "=== Training == #{idx}/#{permutations_count} ======#{perm}========="
      expected_solution = target_pattern.flatten
      @relaxed_puzzle = SlidingPuzzle::RelaxedGrid.new(expected_solution, perm)
      solution = @relaxed_puzzle.solve
      if solution.count>0
        solutions[perm.flatten] = solution
      end
    end
  end

end
