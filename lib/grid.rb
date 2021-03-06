require 'algorithms'
require_relative './errors'
require 'pry'

module SlidingPuzzle
  class Grid
    attr_accessor :statistics, :directions
    def initialize(grid = random_puzzle)
      @directions = []
      #@h = :pattern_database
      @h = :manhattan_distance
      if valid? grid
        @grid = grid
        @statistics = {nodes_visited: 0, nodes_enqueued: 0, directions: [], h: @h}
      else
        raise 'err'
      end
    end

    def compute_pattern(patterns)
      @pdb = SlidingPuzzle::PatternDatabase.new
      @pdb.compute(patterns)

    end

    def grid
      @grid
    end

    def tiles
      @grid.flatten
    end

    def grid_size
      height * width
    end

    def dimensions
      [height, width]
    end

    def height
      @grid.size
    end

    def width
      @grid[0].size
    end

    def to_s
      padding = String(grid_size - 1).size + 1
      @grid.each do |row|
        row.each do |tile|
          print String(tile).rjust(padding)
        end
        puts
      end
    end

    def ==(obj)
      obj.class == self.class && obj.grid == self.grid
    end

    alias_method :eql?, :==

    def slide!(direction)
      r, c = blank_at_row, blank_at_column
      self.tap do
        case direction
        when :left  then swap r, c + 1 unless c == width - 1
        when :right then swap r, c - 1 unless c == 0
        when :up    then swap r + 1, c unless r == height - 1
        when :down  then swap r - 1, c unless r == 0
        else puts 'Valid input for slide: :up, :down, :left, :right'
        end
      end
    end

    def slide(direction)      
      copy = Marshal.load(Marshal.dump(self))
      copy.directions.push(direction)
      copy.slide!(direction)
    end

    def solved?
      v = tiles == [*0...grid_size].rotate(0)
      v
    end

    def solvable?
      (height.odd?  &&  inversions.even?) ||
      (height.even? && (inversions.even?  == blank_at_row.odd?))
    end

    def solve(h=:manhattan_distance, max_time)
      @max_time = max_time
      @time = Time.now
      @h = h
      solved? ? solved : solvable? ? solve_it : insoluble
    end

    def hamming_weight
      tiles.map.with_index do |tile, pos|
        tile == 0 || tile == pos + 1 ? 0 : 1
      end.reduce(:+)
    end

    def pattern_database
      # calcular a distancia entre o problema atual relaxado e uma possível solução
      #manhattan_distance + (@pdb.cost(@grid.flatten).count rescue @pdb.max_cost)
      cost = @pdb.cost(@grid.flatten)
      cost.count rescue 999
      #binding.pry
      # if pdb.nil?
      #   m = manhattan_distance
      #   puts "manhattan_distance #{m}"
      #   return m
      # else
      #   puts "pdb - #{pdb}=>#{cost}"
      #   return pdb
      # end
    end

    def heuristic
      return pattern_database if @h == :pattern_database
      return manhattan_distance if @h == :manhattan_distance
    end

    def manhattan_distance
      #binding.pry
      @grid.map.with_index do |row, r|
        row.map.with_index do |tile, c|
          if tile == 0
            0
          else
            target_row = ((tile - 1) / height) + 1
            target_col = tile % height
            target_col = height if target_col == 0
            (r + 1 - target_row).abs + (c + 1 - target_col).abs
          end
        end
      end.flatten.reduce(:+)
    end

    def linear_conflict
      pairs = 0
      goal = [*0...grid_size].rotate(1).each_slice(width).to_a

      for_rows = [grid, goal]
      for_columns = for_rows.map(&:transpose)

      pair_distance(*for_rows) + pair_distance(*for_columns)
    end

    def random_puzzle(height = 4, width = 4)
      @grid = [*0...height * width].shuffle.each_slice(width).to_a
    end

    private

    def valid?(grid)
      (grid.transpose rescue false) &&
      ([*0...grid.flatten.size] - grid.flatten).empty?
    end

    def blank_at_row
      tiles.index(0) / height
    end

    def blank_at_column
      tiles.index(0) % width
    end

    def swap(x, y)
      r, c = blank_at_row, blank_at_column
      @grid[r][c], @grid[x][y] = @grid[x][y], @grid[r][c]
    end

    def inversions
      tiles.map.with_index do |tile, pos|
        tiles[pos...grid_size].count do |t|
          0 < t && t < tile
        end
      end.reduce(:+)
    end

    def pair_distance(grid, goal)
      pairs = 0
      grid.map.with_index { |row, i| row & goal[i] }
          .select { |r| r.size > 1 }
          .each do |line|
            while tile = line.shift
              if pair = line.find { |t| tile > t }
                pairs += 2
                line.delete pair
              end
            end
          end
      pairs
    end

    def solved
      @grid.tap { puts 'This puzzle is already solved.'}
      []
    end

    def insoluble
      [].tap { puts 'This puzzle cannot be solved.'}
    end

    def solve_it
      a = ida_star
      @statistics[:h] = @h
      @statistics[:directions] = a
      @statistics[:time] = (Time.now - @time)
      @statistics
    end


    def ida_star
      ct = 0
      by_min_value = -> x, y { x <= y }
      q = Containers::PriorityQueue.new &by_min_value


      threshold = priority = heuristic + linear_conflict
      directions = [:up, :down, :left, :right]
      loop do
        state = [[], self, 0]
        q.push(state, priority)

        until priority > threshold
          steps_taken, currently_at, cost = q.pop
          @statistics[:nodes_visited] +=1

          #ct+=1; puts(ct)

          journey = [steps_taken, currently_at]
          
          if currently_at.solved?
            return journey.last.directions            
          end


          directions
            .map { |way| currently_at.slide(way) }
            .tap { cost += 1 }
            .reject { |g| g == currently_at || g == steps_taken.flatten.last }
            .each do |next_step|
              state = [journey, next_step, cost]
              priority = cost + next_step.heuristic + next_step.linear_conflict
              tt = (Time.now - @time)
              #puts tt
              raise "timeout" if (tt>@max_time)
              #binding.pry if next_step.heuristic==1

              @statistics[:nodes_enqueued] +=1
              q.push(state, priority)
            end
        end

        threshold = priority
        q.clear
      end
    end
  end
end
