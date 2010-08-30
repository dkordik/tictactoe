class TicTacToe
  require "utils.rb"
  require "ai/tacker.rb" #to change AIs, change this
  
  def initialize()
    @ai=Tacker.new() #and this
    @spots=[" "," "," "," "," "," "," "," "," "]
    @winning_combos = [123,456,789,147,258,369,159,357]
    @win_color=35 #magenta
    @tt_color=33 #yellow
    @num_moves=0
  end
  
  attr_accessor :num_moves

  def display_grid(prompt=false)
    clear()
    print "\n"
    puts "        #{colorize("TIC TAC TOE",@tt_color)}\n"
    puts "      You  -VS- #{colorize(@ai.name,@ai.color)}\n
     1       2       3
    [#{@spots[0]}]     [#{@spots[1]}]     [#{@spots[2]}]

     4       5       6 
    [#{@spots[3]}]     [#{@spots[4]}]     [#{@spots[5]}]

     7       8       9
    [#{@spots[6]}]     [#{@spots[7]}]     [#{@spots[8]}]


Enter a number between 1 and 9.
    "
    print "GO!> " if prompt == true
  end
  
  def welcome()
    clear()
    print "\n"
    matrix_type "    WELCOME TO TIC TAC TOE."
    sleep(1.5)
    print "\n\n"
    print @ai.face
    matrix_type "     YOUR OPPONENT IS #{@ai.name}"
    sleep(1.5)
    print "\n\n\n"
    matrix_type "    " + bot_dialog(@ai.taunt)
    sleep(3)
  end
  
  def msg(message)
    puts colorize("(#{message})",@tt_color)
    sleep(message.length/15.0)
    self.display_grid()
  end
  
  def animate_placement(player, color, index, prompt_after=false)
    @spots[index]=colorize(player,color)
    self.display_grid()
    sleep(0.5)
    @spots[index]=player
    self.display_grid(prompt_after)
  end

  def move(n)
    allowed_moves=1..@spots.size
    move_index=n-1
    if allowed_moves.include? n and @spots[move_index]==" "
      animate_placement("X", @tt_color, move_index)
      self.num_moves+=1
      true
    elsif allowed_moves.include? n and @spots[move_index]!=" "
      msg "That square is taken"
      false
    else
      msg "Enter a number from 1 to 9"
      false
    end
  end
  
  def computer_move()
    return if self.winner?() or @num_moves==9
    computer_move_index=@ai.move(@spots)
    animate_placement("O", @ai.color, computer_move_index, true)
    self.num_moves+=1
  end
  
  def winner?()
    #on a win, returns an array of the winning cell locations
    @winning_combos.each do |combo|
      cells=combo.to_s.split('')
      cells.each_with_index do |x,i|
        cells[i]=x.to_i-1
      end
      if @spots[cells[0]]==@spots[cells[1]] and @spots[cells[1]]==@spots[cells[2]] and @spots[cells[0]]!=" "
        return cells
      end
    end
    false
  end
  
  def highlight_win()
    cells=self.winner?()
    cells.each do |cell|
      @spots[cell]=colorize(@spots[cell],@win_color)
    end
  end
  
  def display_winner()
    if @spots[self.winner?()[0]]==colorize("X",@win_color)
      print colorize("You WON! ",@win_color)
    else
      print bot_dialog(@ai.victory_taunt)+"\n\n"
      print "You lost. "
    end
  end
  
  def bot_dialog(dialog)
    "[#{@ai.name.upcase}]: " + colorize(dialog,@ai.color)
  end
  
  def display_draw()
    print colorize("It's a DRAW. ", @tt_color)
  end
  
  def play_again?()
    print "Play again? (y/n) [y] "
    choice=gets.chomp.downcase
    while choice!="y" and choice!="n" and choice!=""
      print "Type Y, N, or enter to continue. Play again? (y/n) [y] "
      choice=gets.chomp.downcase
    end
    choice=="y" or choice==""
  end
   
end

