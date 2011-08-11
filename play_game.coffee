TicTacToe = require('./tictactoe').TicTacToe
Players = require('./Players').Players

game = new TicTacToe
state = game.initial

inputCallback = null

stdin = process.openStdin()
stdin.setEncoding 'utf8'
stdin.on 'data', (input) -> inputCallback input

ai = Players.minimax

ask_player = ->
  game.display(state)
  console.log 'put move as x,y'
  inputCallback = (input) ->
    inputCallback = null
    move = {
      x:input.split(',')[0]
      y:input.split(',')[1].slice(0,1)
    }
    state = game.make_move(move,state)
    if game.terminal_test(state)
      winner = if game.utility(state,'X') is 1 then 'X' else 'O'
      console.log "#{winner} won"
      return
    console.log '************'
    move = ai(game,state)
    console.log move
    state = game.make_move(move,state)
    if game.terminal_test(state)
      winner = if game.utility(state,'X') is 1 then 'X' else 'O'
      console.log "#{winner} won"
      return
    ask_player()

ask_player()