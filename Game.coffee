infinity = Number.MAX_VALUE

argmax = (arr,fn) ->
  arr.reduce (current, next) ->
    if fn(next) > fn(current) then next else current

min = (a,b) -> if a>b then b else a

max = (a,b) -> if a>b then a else b

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

  # Return an array of next move/position
  successors: (self, state) ->
    for move in self.legal_moves(state)
      {move:move, position:make_move(move, state)}


minimax_decision = (state,game) ->
  player = game.to_move(state)

  max_value = (state) ->
    if game.terminal_test(state)
      return game.utility(state, player)
    v = -infinity
    for next in game.successors(state)
      v = max(v, min_value(next.state))

  min_value = (state) ->
    if game.terminal_test(state)
      return game.utility(state, player)
    v = infinity
    for next in game.successors(state)
      v = min(v, min_value(next.state))

  result = argmax game.successors(state), (next) ->
    min_value(next.state)

  result.move


alphabeta_full_search = (state, game) ->
  player = game.to_move(state)

  max_value = (state, alpha, beta) ->
    return game.utility(state,player) if game.terminal_test(state)
    v = -infinity
    for next in game.successors(state)
      v = max(v, min_value(next.state, alpha, beta))
      return v if v >= beta
      alpha = max(alpha,v)
    v

  min_value = (state, alpha, beta) ->
    return game.utility(state,player) if game.terminal_test(state)
    v = infinity
    for next in game.successors(state)
      v = min(v, max_value(next.state, alpha, beta))
      return v if v <= alpha
      beta = min(beta,v)
    v

  result = argmax game.successors(state),(next) ->
    min_value(next.state,-infinity,infinity)

  result.move

alphabeta_search = (state, game, d=4, cutoff_test=null, eval_fn=null) ->
  player = game.to_move(state)

  max_value = (state, alpha, beta, depth) ->
    return eval_fn(state) if cutoff_test(state,depth)
    v = -infinity
    for next in game.successors(state)
      v = max(v, min_value(next.state, alpha, beta, depth+1))
      return v if v >= beta
      alpha = max(alpha, v)
    v

  min_value = (state, alpha, beta, depth) ->
    return eval_fn(state) if cutoff_test(state,depth)
    v = infinity
    for next in game.successors(state)
      v = min(v, max_value(next.state, alpha, beta, depth+1))
      return v if v <= alpha
      beta = min(beta, v)
    v

  cutoff_test ?= (state, depth) ->
    depth > d or game.terminal_test(state)

  eval_fn ?= (state) ->
    game.utility(state,player)

  result = argmax game.successors(state),(next) ->
    min_value(next.state, -infinity, infinity, 0)

  result.move



class Fig62Game extends Game
  constructor: ->
    @succs =
      A: [{move:'a1', state:'B'}, {move:'a2', state:'C'}, {move:'a3', state:'D'}]
      B: [{move:'b1', state:'B1'}, {move:'b2', 'B2'}, {move:'b3', state:'B3'}]
      C: [{move:'c1', state:'C1'}, {move:'c2', 'C2'}, {move:'c3', state:'C3'}]
      D: [{move:'d1', state:'D1'}, {move:'d2', 'D2'}, {move:'d3', state:'D3'}]
    @utils = B1:3, B2:12, B3:8, C1:2, C2:4, C3:6, D1:14, D2:5, D3:2
    @initial = 'A'

  successors: (state) ->
    @succs[state] ? []

  utility: (state,player) ->
    if player == 'MAX' then @utils[state] else -@utils[state]

  terminal_test: (state) ->
    state not in ['A', 'B', 'C', 'D']

  to_move: (state) ->
    if state in ['B','C','D'] then 'MIN' else 'MAX'

fig62 = new Fig62Game

console.log fig62.successors('A')
console.log minimax_decision('A',fig62)
console.log alphabeta_full_search('A',fig62)
console.log alphabeta_search('A',fig62)
