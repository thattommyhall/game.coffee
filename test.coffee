_ = require './underscore'
{Fig62Game} = require './fig62'
{Players} = require './players'
{TicTacToe} = require './tictactoe'
{TestGame} = require './testgame'

f62 = new Fig62Game
ttt = new TicTacToe
tg = new TestGame



exports.testf62 = (test) ->
  alphabeta = Players.alphabeta()
  test.equal alphabeta(f62,f62.initial),'a1'
  test.equal Players.alphabeta_full(f62,f62.initial),'a1'
  test.equal Players.minimax(f62,f62.initial),'a1'
  test.done()

exports.testTicTacToe = (test) ->
  test_state =
    to_move: 'O'
    board:
      [ [ 'X', 'O', '.' ],
        [ 'O', 'X', '.' ],
        [ 'X', '.', 'O' ] ]
    utility: 0

  test.deepEqual Players.minimax(ttt,test_state),Players.alphabeta()(ttt,test_state)
  test.deepEqual Players.minimax(ttt,test_state),Players.alphabeta_full(ttt,test_state)
  test.deepEqual ttt.legal_moves(test_state),
    [ { x: 1, y: 2 }, { x: 2, y: 0 }, { x: 2, y: 1 } ]

  test_state2 =
    to_move: 'O'
    board:
      [ [ 'O', 'X', 'X' ],
        [ '.', 'X', '.' ],
        [ 'O', 'O', 'X' ] ]

    utility: 0

  test.deepEqual Players.minimax(ttt,test_state2),Players.alphabeta()(ttt,test_state2)
  test.deepEqual Players.minimax(ttt,test_state2),Players.alphabeta_full(ttt,test_state2)
  test.deepEqual { x: 0, y: 1 },Players.minimax(ttt,test_state2)

  test.done()

exports.testTestGame = (test) ->
  alphabeta = Players.alphabeta()
  test.equal alphabeta(tg,'A'),'a1'
  test.equal Players.alphabeta_full(tg,'A'),'a1'
  test.equal Players.minimax(tg,'A'),'a1'
  test.done()