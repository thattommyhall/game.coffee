{Game} = require './game'
_ = require './underscore'

deepCopy = (obj) ->
  switch typeof obj
    when 'object'
      if typeof obj.length is 'undefined'
        result = {}
      else
        result = []
      for key,val of obj
        result[key] = deepCopy obj[key]
      return result
    when 'string','number','boolean','function'
      return obj

class TicTacToe extends Game
  constructor: ->
    @initial =
      to_move: 'X'
      board: '.' for y in [0..2] for x in [0..2]
      utility: 0

  legal_moves: (state) ->
    moves = []
    for x in [0..2]
      for y in [0..2]
        moves.push({x,y}) if state.board[y][x] is '.'
    moves

  make_move: (move,state) ->
    board = deepCopy(state.board)
    board[move.y][move.x] = state.to_move
    {
      to_move: if state.to_move == 'X' then 'O' else 'X'
      board: board
      utility: @calculate_utility(board,move,state.to_move)
    }

  utility: (state,player) ->
    if player is 'X' then state.utility else -state.utility

  calculate_utility: (board,last_move,player) ->
      if (_.all([0,1,2],(n) -> board[n][last_move.x] is player) or
          _.all([0,1,2],(n) -> board[n][last_move.x] is player) or
          (board[0][0] == board[1][1] == board[2][2] == player) or
          (board[0][2] == board[1][1] == board[2][0] == player))
        if player is 'X' then 1 else -1
      else 0

  terminal_test: (state) ->
    @utility(state) != 0 or @legal_moves(state).length == 0

  to_move: (state) ->
    state.to_move

  display: (state) ->
    console.log state.board

root = exports ? window
root.TicTacToe = TicTacToe