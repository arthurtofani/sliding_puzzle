require 'algorithms'
require_relative './errors'
require 'pry'

class SlidingPuzzle::RelaxedGrid < SlidingPuzzle::Grid

  attr_accessor :directions
  def initialize(solution, grid = random_puzzle)
    @directions = []
    @statistics = {nodes_visited: 0}
    @grid = grid
    @solution = solution

  end

  def solved?
    (tiles == @solution)
  end


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


  def ida_star
    ct = 0
    by_min_value = -> x, y { x <= y }
    q = Containers::PriorityQueue.new &by_min_value

    threshold = priority = manhattan_distance + linear_conflict
    directions = [:up, :down, :left, :right]

    loop do
      state = [[], self, 0]
      q.push(state, priority)

      until priority > threshold
        steps_taken, currently_at, cost = q.pop


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
            priority = cost + next_step.manhattan_distance + next_step.linear_conflict
            q.push(state, priority)
          end
      end

      threshold = priority
      q.clear
    end
  end


end
