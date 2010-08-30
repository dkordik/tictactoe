class Tacker
=begin
    T A C K E R
      A HARD 
 TIC TAC TOE PLAYER
      _______
     |  \ /  |
     |  ' '  |
      \ (") /
       \___/
=end
  def initialize()
    @name="Tacker"
    @color=31 #red
    @taunt="Prepare to die!"
    @victory_taunt="I have defeated you!"
    @face="
    _______
   |  \\ /  |
   |  ' '  |
    \\ (\") /
     \\___/"
       
    @winning_combos = [123,456,789,147,258,369,159,357]
    @two_of_threes = []
    @winning_combos.each do |combo|
      combo=combo.to_s.split("")
      @two_of_threes << [(combo[0]+combo[1]),combo[2].to_i]
      @two_of_threes << [(combo[1]+combo[2]),combo[0].to_i]
      @two_of_threes << [(combo[0]+combo[2]),combo[1].to_i]
    end
  end
  
  attr_reader :name, :color, :taunt, :victory_taunt, :face
  
  def move(grid)
    # Based on Wikipedia's method for perfect Tic Tac Toe play priority
    # http://en.wikipedia.org/wiki/Tic-tac-toe
    @empty_side=empty_side(grid)
    @empty_corner=empty_corner(grid)
    # WIN
    third_in_a_row=find_third_in_a_row(grid,"O")
    return third_in_a_row if third_in_a_row
    # BLOCK
    third_in_a_row=find_third_in_a_row(grid,"X")
    return third_in_a_row if third_in_a_row
    # FORK
    if grid[4]=="O"
      if (grid[3]=="X" and grid[5]=="X") or (grid[1]=="X" and grid[7]=="X")
        if @empty_side
          return @empty_side 
        elsif grid[0]==" " and grid[2]==" " and grid[6]==" " and grid[8]==" "
          return [0,2].sort_by{rand}[0] if grid[1]=="O"
          return [0,6].sort_by{rand}[0] if grid[3]=="O"
          return [6,8].sort_by{rand}[0] if grid[7]=="O"
          return [2,8].sort_by{rand}[0] if grid[5]=="O"
        end
      end
    end
    # BLOCK OPPONENT'S FORK
    if grid[4]=="O"
      if (grid[0]=="X" and grid[8]=="X") or (grid[2]=="X" and grid[6]=="X")
        return @empty_side if @empty_side
      end 
    end
    # CENTER
    return 4 if grid[4]==" "
    # OPPOSITE CORNER
    return 8 if grid[0]=="X" and grid[8]==" "
    return 0 if grid[8]=="X" and grid[0]==" "
    return 6 if grid[2]=="X" and grid[6]==" "
    return 2 if grid[6]=="X" and grid[2]==" "
    # EMPTY CORNER
    return @empty_corner if @empty_corner
    # EMPTY SIDE
    return @empty_side if @empty_side
  end
  
  def empty_side(grid)
    [2,4,6,8].sort_by{rand}.each do |side|
      return side-1 if grid[side-1]==" "
    end
    false
  end
  
  def empty_corner(grid)
    [1,3,7,9].sort_by{rand}.each do |corner|
      return corner-1 if grid[corner-1]==" "
    end
    false
  end
  
  def find_third_in_a_row(grid, player="X")
    @two_of_threes.each do |two_of_three|
      if grid[two_of_three[1]-1]==" "
        two=two_of_three[0].split('')
        if grid[two[0].to_i-1]==grid[two[1].to_i-1] and grid[two[0].to_i-1]==player
          return two_of_three[1]-1
        end
      end
    end
    false
  end
  
end



