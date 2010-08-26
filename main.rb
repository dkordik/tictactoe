require "tictactoe.rb"

@game=TicTacToe.new()
@keep_playing=true

@game.welcome()
@game.display_grid(true)

while @keep_playing

  while not @game.winner?() and @game.num_moves<9
    if @game.move(gets.chomp.to_i)
      @game.computer_move()
    end
  end
  
  if not @game.winner?()
    @game.display_grid()
    @game.display_draw()
  else
    @game.highlight_win()
    @game.display_grid()
    @game.display_winner()    
  end
  sleep(1)
  @keep_playing=@game.play_again?()
  
  if @keep_playing
    @game=TicTacToe.new()
    @game.display_grid(true)
    @game.num_moves=0
  end
  
end