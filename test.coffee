_ = require './underscore'
{Fig62Game} = require './fig62'
{Players} = require './players'
{TicTacToe} = require './tictactoe'
assert = require 'assert'

f62 = new Fig62Game
ttt = new TicTacToe

assert.equal Players.alphabeta(f62,f62.initial),'a1'
assert.equal Players.alphabeta_full(f62,f62.initial),'a1'
assert.equal Players.minimax(f62,f62.initial),'a1'

test_state =
  to_move: 'O'
  board:
    [ [ 'X', 'O', '.' ],
      [ 'O', 'X', '.' ],
      [ 'X', '.', 'O' ] ]
  utility: 0

assert.deepEqual Players.minimax(ttt,test_state),Players.alphabeta(ttt,test_state)
assert.deepEqual Players.minimax(ttt,test_state),Players.alphabeta_full(ttt,test_state)
assert.deepEqual ttt.legal_moves(test_state),
  [ { x: 1, y: 2 }, { x: 2, y: 0 }, { x: 2, y: 1 } ],
  "legal_moves works"

test_state2 =
  to_move: 'O'
  board:
    [ [ 'O', 'X', 'X' ],
      [ '.', 'X', '.' ],
      [ 'O', 'O', 'X' ] ]

  utility: 0

assert.deepEqual Players.minimax(ttt,test_state2),Players.alphabeta(ttt,test_state2)
assert.deepEqual Players.minimax(ttt,test_state2),Players.alphabeta_full(ttt,test_state2)
assert.deepEqual { x: 0, y: 1 },Players.minimax(ttt,test_state2)



