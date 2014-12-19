Game_2048
=========

WIP for the Elixir Quiz: [2048 game clone](http://elixirquiz.github.io/2014-12-13-2048-game.html)

# How to use:
```
$ git clone git@github.com:Tuxified/elixir_quiz-game_2048.git
$ cd game_2048
$ iex -S mix
iex(1)>Game_2048.start
```

Use hjkl (vi keys, followed by a return) to move left,down,up,right(respectively).

# TODO

- new tile should be random of 2 or 4 (currently always 2)
- check for game end status (no moves possible or reached 2048)
- keep track of score
- improve board layout (currently using tabs between tiles)

- moar tests? especially for merging tiles
- split up game logic from controls in order to make it easy to implement a different interface
- mold into OTP standard so it can be used as a game server
