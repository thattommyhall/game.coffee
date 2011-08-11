{Game} = require './game'

class Fig62Game extends Game
  constructor: ->
    @succs =
      A: [{move:'a1', state:'B'}, {move:'a2', state:'C'}, {move:'a3', state:'D'}]
      B: [{move:'b1', state:'B1'}, {move:'b2', state:'B2'}, {move:'b3', state:'B3'}]
      C: [{move:'c1', state:'C1'}, {move:'c2', state:'C2'}, {move:'c3', state:'C3'}]
      D: [{move:'d1', state:'D1'}, {move:'d2', state:'D2'}, {move:'d3', state:'D3'}]
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


root = exports ? window
root.Fig62Game = Fig62Game
