class Game
   # Return a list of the allowable moves at this point.
  legal_moves: (state) ->
    throw new Error('Need to implement legal_moves')

   # Return the state that results from making a move from a state.
  make_move: (move,state) ->
    throw new Error('Need to implement make_move')

   # Return the value of this final state to player.
  utility: (state, player) ->
    throw new Error('Need to implement utility')

  # Return True if this is a final state for the game.
  terminal_test: (state)->
    legal_moves(state).length is 0

  # Return the player whose move it is in this state.
  to_move: (state) ->
    return state.to_move

  # Print or otherwise display the state.
  display: (state) ->
    console.log state

  # Return an array of next move/state
  successors: (state) ->
    for move in @legal_moves(state)
      {move:move, state:@make_move(move, state)}

root = exports ? window
root.Game = Game