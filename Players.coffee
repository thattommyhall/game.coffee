infinity = Number.MAX_VALUE

argmax = (arr,fn) ->
  arr.reduce (current, next) ->
    if fn(next) > fn(current) then next else current

min = (a,b) -> if a>b then b else a

max = (a,b) -> if a>b then a else b

minimax = (game, state) ->
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

  (argmax game.successors(state), (next) -> min_value(next.state)).move

alphabeta_full = (game, state) ->
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

alphabeta = (d=4, cutoff_test=null, eval_fn=null) ->
  max_value = (game, state, alpha, beta, depth) ->
    return eval_fn(state) if cutoff_test(state,depth)
    v = -infinity
    for next in game.successors(state)
      v = max(v, min_value(game,next.state, alpha, beta, depth+1))
      return v if v >= beta
      alpha = max(alpha, v)
    v

  min_value = (game,state, alpha, beta, depth) ->
    return eval_fn(state) if cutoff_test(state,depth)
    v = infinity
    for next in game.successors(state)
      v = min(v, max_value(game,next.state, alpha, beta, depth+1))
      return v if v <= alpha
      beta = min(beta, v)
    v

  (game,state) ->
    eval_fn ?= (state) ->
      game.utility(state,player)

    cutoff_test ?= (state, depth) ->
      depth > d or game.terminal_test(state)

    player = game.to_move(state)

    result = argmax game.successors(state),(next) ->
      min_value(game,next.state, -infinity, infinity, 0)

    result.move

random = (game,state) ->
  Array.random(game.legal_moves(state))

Array.random = (array) ->
  array[Math.floor(Math.random() * array.length)]

Players = {alphabeta,alphabeta_full,minimax,random}

root = exports ? window
root.Players = Players