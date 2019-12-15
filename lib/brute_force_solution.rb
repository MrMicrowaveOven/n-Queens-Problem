require_relative 'board'

def find_solution(n)
  solution_board = nil
  while true
    board = Board.new(n)

    spaces = get_random_spaces(n)

    spaces.each { |space| board.place_queen(space) }

    if board.is_solution
      solution_board = board
      break
    end
  end
  return solution_board.show_queens
end

def get_random_spaces(n)
  random_spaces = []
  columns = []
  n.times do |i|
    until random_spaces.length == i + 1
      column = rand(n)
      next if columns.include?(column)
      random_spaces << [i, column]
      columns << column
    end
  end
  random_spaces
end
