require_relative '../lib/brute_force_solution'

describe 'get_random_spaces' do
  it 'gives the right number of spaces' do
    expect(get_random_spaces(8).length).to eq(8)
  end

  it "doesn't repeat rows, because it should move by row" do
    random_spaces = get_random_spaces(8)
    rows = random_spaces.map { |space| space[0] }
    expect(rows.sort).to eq((0..7).to_a)
  end

  it "doesn't repeat columns, because those are obvious fails" do
    random_spaces = get_random_spaces(8)
    columns = random_spaces.map { |space| space[1] }
    expect(columns.sort).to eq((0..7).to_a)
  end
end
