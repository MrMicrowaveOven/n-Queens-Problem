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

class Board
  def initialize(n)
    @board = Array.new(n) { Array.new(n) }
  end

  def n
    @board.length
  end

  def place_queen(space)
    @board[space[0]][space[1]] = true
  end

  def remove_queen(space)
    @board[space[0]][space[1]] = nil
  end

  def has_queen(space)
    @board[space[0]][space[1]] == true
  end

  def is_valid_space(space)
    return space[0] <= n - 1 && space[1] <= n - 1 && space[0] >= 0 && space[1] >= 0
  end

  def is_solution
    killer = false
    @board.each_with_index do |row, index|
      queen_at = row.index(true)
      queen_space = [index, queen_at]
      if is_kill_spot(queen_space)
        killer = true
        break
      end
    end
    !killer
  end

  def is_kill_spot(space)
    verticals = get_verticals(space)
    diagonals = get_diagonals(space)
    all_accessible_spots = verticals + diagonals
    all_accessible_spots.any? {|space| has_queen(space)}
  end

  def get_verticals(space)
    verts = []
    n.times do |i|
      verts << [i, space[1]]
    end
    verts.delete(space)
    verts
  end

  def get_diagonals(space)
    diagonals = []

    diagonals += get_diagonals_in_direction(space, [-1, -1])
    diagonals += get_diagonals_in_direction(space, [1, -1])
    diagonals += get_diagonals_in_direction(space, [-1, 1])
    diagonals += get_diagonals_in_direction(space, [1, 1])

    diagonals
  end

  def show_queens
    spaces = []
    @board.each_with_index do |row, index|
      queen_at = row.index(true)
      spaces << [index, queen_at]
    end
    spaces
  end

  private

  def get_diagonals_in_direction(space, direction)
    diagonals = []
    moving_space = space

    while true
      moving_space = [moving_space[0] + direction[0], moving_space[1] + direction[1]]
      break if !is_valid_space(moving_space)
      diagonals << moving_space
    end
    diagonals
  end
end
