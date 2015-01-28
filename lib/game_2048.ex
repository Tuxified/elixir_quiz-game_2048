defmodule Game_2048 do

  def start do
    board = new_game
    run(board)
  end

  def run(board) do
    print_board(board)
    move = get_input
    run(next_state(board, move))
  end

  def print_board(board) do
    IO.ANSI.format([:home, :clear]) |>
    IO.puts

    Enum.each board, fn row ->
      Enum.intersperse(row, "\t") |>
      Enum.join |>
      IO.puts
    end
  end

  def get_input do
    move = IO.gets("Use hjkl to move left,down,up,right:\n")
    char_to_move String.first(move)
  end

  @spec char_to_move(char()) :: atom()
  def char_to_move(character) do
    cond do
      String.upcase(character) == "H" -> :left
      String.upcase(character) == "J" -> :down
      String.upcase(character) == "K" -> :up
      String.upcase(character) == "L" -> :right
      true -> :invalid
    end
  end

  def next_state(board, direction) do
    board                   |>
    move_tiles(direction)   |>
    merge_tiles(direction)  |>
    move_tiles(direction)   |>
    new_tile
  end

  def move_tiles(board, :right) do
    Enum.map board, fn(row) ->
      Enum.partition(row, &(is_nil(&1))) |>
      Tuple.to_list |>
      Enum.concat
    end
  end

  def move_tiles(board, :left) do
    Enum.map board, fn(row) ->
      Enum.partition(row, &(is_nil(&1))) |>
      Tuple.to_list |>
      Enum.reverse  |>
      Enum.concat
    end
  end

  def move_tiles(board, :down) do
    board               |>
    transpose           |>
    move_tiles(:right)  |>
    transpose
  end

  def move_tiles(board, :up) do
    board             |>
    transpose         |>
    move_tiles(:left) |>
    transpose
  end

  def merge_tiles(board, :left) do
    Enum.map board, &(merge_row(&1))
  end

  def merge_tiles(board, :right) do
    Enum.map board, fn(row) ->
      row           |>
      Enum.reverse  |>
      merge_row     |>
      Enum.reverse
    end
  end

  def merge_tiles(board, :down) do
    board               |>
    transpose           |>
    merge_tiles(:right) |>
    transpose
  end

  def merge_tiles(board, :up) do
    board               |>
    transpose           |>
    merge_tiles(:left)  |>
    transpose
  end

  def new_tile(board) do
    flat_board = List.flatten(board)
    flat_board |>
    Enum.with_index |>
    Enum.filter(fn({v,_i}) -> is_nil(v) end) |>
    Enum.shuffle |>
    List.first |>
    to_replace(flat_board) |>
    to_board
  end

  def new_game do
    [
      [ nil,  nil,  nil,  nil ],
      [ nil,  nil,  nil,  nil ],
      [ nil,  nil,  nil,  nil ],
      [ nil,  nil,  nil,  nil ],
    ] |> new_tile |> new_tile
  end

  def merge_row([nil, nil, x, x]) when is_nil(x) == false do
    [nil, nil, x + x, nil]
  end

  def merge_row([ x, x | tail]) when is_nil(x) == false do
    [ x + x, nil | merge_row(tail)]
  end

  def merge_row([ a, x, x | tail]) when is_nil(x) == false do
    [ a, x + x, nil | tail]
  end

  def merge_row([a, b, x, x]) when is_nil(x) == false do
    [a, b, x + x, nil]
  end

  def merge_row(row), do: row

  def to_board(list), do: Enum.chunk(list, 4)

  def to_replace({_v, spot}, list) do
    :random.seed(:os.timestamp)
    two_or_four = :random.uniform(2) * 2
    List.replace_at(list, spot, two_or_four)
  end

  def transpose(board) do
    board |>
    List.zip |>
    Enum.map &(Tuple.to_list(&1))
  end

end
