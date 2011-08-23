{Game} = require './game'

class TestGame extends Game
  constructor: ->
    @succs =
      A: [{move:'a1', state:'B'}, {move:'a2', state:'C'}]
      B: [{move:'b1', state:'D'}, {move:'b2', state:'E'}]
      C: [{move:'c1', state:'F'}, {move:'c2', state:'G'}]
      D: [{move:'d1', state:'D1'}, {move:'d2', state:'D2'}]
      E: [{move:'e1', state:'E1'}, {move:'e2', state:'E2'}]
      F: [{move:'f1', state:'F1'}, {move:'f2', state:'F2'}]
      G: [{move:'g1', state:'G1'}, {move:'g2', state:'G2'}]
    @utils = D1:3, D2:12, E1:8, E2:2, F1:4, F2:6, G1:14, G2:5
    @initial = 'A'

  successors: (state) ->
    @succs[state] ? []

  utility: (state,player) ->
    if player == 'MAX' then @utils[state] else -@utils[state]

  terminal_test: (state) ->
    state not in ['A', 'B', 'C', 'D', 'E', 'F', 'G']

  to_move: (state) ->
    if state in ['A','D','E','F','G'] then 'MAX' else 'MIN'

root = exports ? window
root.TestGame = TestGame
