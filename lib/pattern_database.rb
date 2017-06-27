require 'unique_permutation'
require 'pry'
class SlidingPuzzle::PatternDatabase

  attr_accessor :target_pattern

  def initialize(target_pattern)
    @target_pattern = target_pattern
  end

  def train
    # monta a base de soluções para o problema relaxado
    permutations = target_pattern.flatten.unique_permutation
    permutations_count = permutations.count

    permutations.each_with_index do |permutation, idx|
      next if idx==0
      perm = permutation.each_slice(3).to_a
      puts "=== Training == #{idx}/#{permutations_count} ======#{perm}========="
      @relaxed_puzzle = SlidingPuzzle::RelaxedGrid.new(target_pattern.flatten, perm)
      @relaxed_puzzle.solve
    end
  end

end
