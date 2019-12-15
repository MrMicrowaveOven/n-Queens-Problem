require_relative '../lib/board'

require 'byebug'

describe 'is_solution' do
  it 'returns false when queens can kill each other (3x3)' do
    board = Board.new(3)
    board.place_queen([0,0])
    board.place_queen([1,1])
    board.place_queen([2,2])

    expect(board.is_solution).to eq(false)
  end

  it 'returns false when queens can kill each other (4x4)' do
    board = Board.new(4)
    board.place_queen([2,0])
    board.place_queen([0,1])
    board.place_queen([1,2])
    board.place_queen([3,3])

    expect(board.is_solution).to eq(false)
  end

  it 'returns true when queens cannot kill each other' do
    board = Board.new(4)
    board.place_queen([2,0])
    board.place_queen([0,1])
    board.place_queen([3,2])
    board.place_queen([1,3])

    expect(board.is_solution).to eq(true)
  end
end

describe 'get_diagonals' do
  it 'returns all diagonals given a space in a 3x3 board' do
    board = Board.new(3)
    diagonals = board.get_diagonals([0, 0])
    expect(diagonals.sort).to eq([[1,1], [2,2]].sort)

    diagonals = board.get_diagonals([1, 1])
    expect(diagonals.sort).to eq([[0,0], [0,2], [2,0], [2,2]].sort)
  end
end

describe 'get_verticals' do
  it 'returns all verticals given a space' do
    board =  Board.new(8)
    verts = board.get_verticals([3, 5])
    expect(verts).to eq([
        [0,5],
        [1,5],
        [2,5],
        [4,5],
        [5,5],
        [6,5],
        [7,5],
    ])
  end
end

describe 'is_valid_space' do
  it 'confirms a valid space' do
    board = Board.new(8)
    expect(board.is_valid_space([0,0])).to eq(true)
    expect(board.is_valid_space([7,7])).to eq(true)
  end
  it 'returns false if space is out of range' do
    board = Board.new(8)
    expect(board.is_valid_space([1,8])).to eq(false)
    expect(board.is_valid_space([-1,7])).to eq(false)
  end
end
