class Ticky
=begin
      Ticky
    A Very Dumb 
 TIC TAC TOE PLAYER
      ___/___
     |  - \  |
     |  ? o  |
      ( ___ )
       \___/
=end

  def initialize()
    @name="Ticky"
    @color=36 #cyan
    @taunt="Go easy on me..."
    @victory_taunt="Yay, I won!"
    @face="
     ___/___
    |  - \\  |
    |  ? o  |
     ( ___ )
      \\___/"
    @cells=[1,2,3,4,5,6,7,8,9]
  end
  
  attr_reader :name, :color, :taunt, :victory_taunt, :face
  
  def move(grid)
    @cells.sort_by{rand}.each do |cell|
      return cell-1 if grid[cell-1]==" "
    end
  end
  
end



