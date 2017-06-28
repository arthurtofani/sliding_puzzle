require 'unique_permutation'
require 'pry'
require 'digest/sha1'
class SlidingPuzzle::PatternDatabase

  attr_accessor :solutions

  def initialize
    @solutions = {}    
    #@allowed_symbols = (@target_pattern.flatten.uniq - [-1])
    @loaded = false
  end

  def target_name(target_pattern)
    Digest::SHA1.hexdigest(target_pattern.to_s)
  end

  def max_cost
    @solutions.values.map{|s| s.count}.max
  end

  def persist(target_pattern)
    f = File.open("training/#{target_name(target_pattern)}.txt", "w")
    f.puts Marshal.dump(@solutions)
    f.close
    puts "Training saved"
  end

  def load_solutions(target_patterns)
    #puts @solutions.count
    @solutions || {}
    target_patterns.each do |target_pattern|
    
    begin
      @solutions.merge!(Marshal.load(File.open("training/#{target_name(target_pattern)}.txt", "r").read))
      @loaded = true
      #puts "Loaded from file"
    rescue      
      puts "Cant load from file, needs new training"            
      train!(target_pattern)
    end
    @loaded = false
    end
  end

  def find_pattern_directions(entry)
    ptn = @pattern_formats.map do |frmt|
      entry.map{|s| ((frmt.include? s) ? s : -1)}
    end
    ptn.map{|s| get_solution(s)}.compact.uniq.sort{|a, b| a.count<=>b.count}.last

  end

  def cost(entry)    
    cost = find_pattern_directions(entry)
    #puts "#{entry} - #{cost}"
    cost
    #pattern = entry.map{|s| ((@allowed_symbols.include? s) ? s : -1)}
    #directions = get_solution(pattern)
    #binding.pry if (directions.count rescue 0)==4
    #directions
  end

  def get_solution(key)
    @solutions[key]
  end

  def set_solution(key, value)
    @solutions[key] = value
  end

  def train(target_patterns)
    load_solutions(target_patterns)
    @solutions.keys.each do |key|
      @solutions.delete(key) if @solutions[key].count == 0
    end
    @pattern_formats = @solutions.keys.map{|s| s.map{|r| (r==-1) ? nil : r}.compact.sort}.uniq
  end

  def train!(target_pattern)
    # monta a base de soluções para o problema relaxado
    permutations = target_pattern.flatten.unique_permutation
    permutations_count = permutations.count

    permutations.each_with_index do |permutation, idx|
      next if idx==0
      #next if idx>200
      perm = permutation.each_slice(3).to_a
      puts "=== Training == #{idx}/#{permutations_count} ======#{perm}========="
      expected_solution = target_pattern.flatten
      @relaxed_puzzle = SlidingPuzzle::RelaxedGrid.new(expected_solution, perm)
      solution = @relaxed_puzzle.solve
      flat_array = perm.flatten
      previous_solution_count = (get_solution(flat_array).count rescue 99999)
      if solution.count<previous_solution_count && solution.count>0
        set_solution(flat_array, solution)
      end

    end
    #binding.pry
    persist(target_pattern)

  end

end
