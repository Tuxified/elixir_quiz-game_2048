defmodule Game_2048Test do
  use ExUnit.Case, async: true
  import Game_2048

  #################
  # move tiles    #
  #################
  test "simple move right" do
    board = [
              [ nil, 2, nil, 2 ],
              [ nil, nil, nil, nil],
            ]

    moved = [
              [ nil, nil, 2, 2 ],
              [ nil, nil, nil, nil],
            ]

    assert move_tiles(board, :right) == moved
  end

    test "simple move left" do
      board = [
                [ nil, 2, nil, 4 ],
                [ nil, nil, 4, nil],
              ]

      moved = [
                [ 2, 4, nil, nil ],
                [ 4, nil, nil, nil],
              ]

      assert move_tiles(board, :left) == moved
    end

  test "another simple merge left" do
    board = [[ 2, 4, 8, 8 ]]
    moved = [[ 2, 4, 16, nil]]

    assert merge_tiles(board, :left) == moved
  end

  test "simple move down" do
    board = [
              [ nil,  2,    nil,  4 ],
              [ nil,  nil,  4,    nil],
            ]

    moved = [
              [ nil,  nil,  nil,  nil ],
              [ nil,  2,    4,    4],
            ]

    assert move_tiles(board, :down) == moved
  end

  test "simple move up" do
    board = [
              [ 2,    nil,    nil,  4 ],
              [ nil,  nil,    4,    nil],
              [ 4,    4,      4,    4]
            ]

    moved = [
              [ 2,    4,    4,    4],
              [ 4,    nil,  4,    4],
              [ nil,  nil,  nil,  nil ]
            ]

    assert move_tiles(board, :up) == moved
  end

  # #################
  # # merge tiles    #
  # #################
  test "left aligned merge left" do
    board   = [[2, 2, 2, nil]]
    merged  = [[4,nil,2,nil]]

    assert merge_tiles(board, :left) == merged
  end

  test "medior merge left" do
    board   = [[nil, 2, 2, nil]]
    merged  = [[nil,4,nil,nil]]

    assert merge_tiles(board, :left) == merged
  end


  test "right aligned merge left" do
    board   = [[nil, 2, 2, 2]]
    merged  = [[nil,4,nil, 2]]

    assert merge_tiles(board, :left) == merged
  end

  test "right aligned merge left versie twee" do
    board   = [[nil, nil, 2, 2]]
    merged  = [[nil,nil,4, nil]]

    assert merge_tiles(board, :left) == merged
  end

  test "advanced merge left" do
    board   = [[2, 2, 2, 2]]
    merged  = [[4,nil,4,nil]]

    assert merge_tiles(board, :left) == merged
  end

  test "left aligned merge right" do
    board   = [[2, 2, 2, nil]]
    merged  = [[2,nil,4,nil]]

    assert merge_tiles(board, :right) == merged
  end

  test "medior merge right" do
    board   = [[nil, 2, 2, nil]]
    merged  = [[nil,nil,4,nil]]

    assert merge_tiles(board, :right) == merged
  end


  test "right aligned merge right" do
    board   = [[nil, 2, 2, 2]]
    merged  = [[nil,2,nil, 4]]

    assert merge_tiles(board, :right) == merged
  end

  test "right aligned merge right versie twee" do
    board   = [[nil, nil, 2, 2]]
    merged  = [[nil,nil,nil, 4]]

    assert merge_tiles(board, :right) == merged
  end

  test "advanced merge right" do
    board   = [[2, 2, 2, 2]]
    merged  = [[nil,4,nil,4]]

    assert merge_tiles(board, :right) == merged
  end

  test "simple merge down" do
    board = [
              [ nil,  2,    nil,  4 ],
              [ nil,  2,    4,    4],
            ]

    merged = [
              [ nil,  nil,  nil,  nil ],
              [ nil,  4,    4,    8],
            ]
    assert merge_tiles(board, :down) == merged
  end

  test "advanced merge down" do
    board = [
              [ nil,  nil,  nil,  nil ],
              [ nil,  2,    nil,  4 ],
              [ nil,  2,    nil,  4 ],
              [ nil,  2,    4,    4],
            ]

    merged = [
              [ nil,  nil,  nil,  nil ],
              [ nil,  2,    nil,  4 ],
              [ nil,  nil,  nil,  nil ],
              [ nil,  4,    4,    8],
            ]

    assert merge_tiles(board, :down) == merged
  end

  test "simple merge up" do
    board = [
              [ nil,  2,    nil,  4 ],
              [ nil,  2,    4,    4],
            ]

    merged = [
              [ nil,  4,    nil,    8],
              [ nil,  nil,  4,  nil ],
            ]
    assert merge_tiles(board, :up) == merged
  end

  test "advanced merge up" do
    board = [
              [ nil,  nil,  nil,  nil ],
              [ nil,  2,    nil,  4 ],
              [ nil,  2,    nil,  4 ],
              [ nil,  2,    4,    4],
            ]

    merged = [
              [ nil,  nil,  nil,  nil ],
              [ nil,  4,    nil,  8 ],
              [ nil,  nil,  nil,  nil ],
              [ nil,  2,    4,    4],
            ]

    assert merge_tiles(board, :up) == merged
  end

  test "transpose board" do
    assert transpose([[1,2], [3,4]]) == [[1,3], [2,4]]
  end

  test "vector/list to board" do
    assert to_board(1..16) == [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]
  end
end
