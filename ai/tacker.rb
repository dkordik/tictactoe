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
    @two_of_threes
  end
  
  attr_reader :name, :color, :taunt, :victory_taunt, :face
  
  def move(grid)
    # Based on Wikipedia's method for perfect Tic Tac Toe play priority
    # http://en.wikipedia.org/wiki/Tic-tac-toe
    @empty_side=empty_side(grid)
    @empty_corner=empty_corner(grid)
    #1. WIN
      third_in_a_row=find_third_in_a_row(grid,"O")
      if third_in_a_row
        return third_in_a_row
      end
    #2. BLOCK
      third_in_a_row=find_third_in_a_row(grid,"X")
      if third_in_a_row
        return third_in_a_row
      end
    #4. BLOCK OPPONENT'S FORK
      if grid[4]=="O"
        if (grid[0]=="X" and grid[8]=="X") or (grid[2]=="X" and grid[6]=="X")
          return @empty_side if @empty_side
        end 
      end
    #5. CENTER
      if grid[4]==" "
        return 4
      end
    #6. OPPOSITE CORNER
      if grid[0]=="X" and grid[8]==" "
        return 8
      elsif grid[8]=="X" and grid[0]==" "
        return 0
      elsif grid[2]=="X" and grid[6]==" "
        return 6
      elsif grid[6]=="X" and grid[2]==" "
        return 2
      end
    #7. EMPTY CORNER
      return @empty_corner if @empty_corner
    #8. EMPTY SIDE
      return @empty_side if @empty_side
  end
  
  def empty_side(grid)
    [2,4,6,8].sort_by{rand}.each do |side|
      if grid[side-1]==" "
        return side-1
      end
    end
    false
  end
  
  def empty_corner(grid)
    [1,3,7,9].sort_by{rand}.each do |corner|
      if grid[corner-1]==" "
        return corner-1
      end
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



