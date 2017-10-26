# Draws a velocity vector in the direction of a bullet inside the @bullets array
require "rubygame/ftor"
class Visualize
  EXT_LEN = 15
  include Rubygame
  def initialize(width=WIDTH,height=HEIGHT)
    @groups = []
    @bullets = []
    @depth = 0
    @width,@height = width,height
    @surface = Surface.new([width,height])
    @orig_surface = Surface.new([width,height])
    #@original_background = Surface.load("/vship/lib/background.png") #wouldn't hurt to figure out how to duplicate this stuff
	@original_background = Surface.new([width,height])
	
    @original_surface = Surface.new([width,height])
    @ob_rect = @original_background.make_rect  
    @os_rect = @original_surface.make_rect  
  end
  
  def blit(onto,ship)
    @original_background.blit(@surface,[0,0]) #reverse blit
    @bullets.each { |bullet|
      if bullet.alive? == true
        pos_vector,vel_vector=Ftor.new(0,0),Ftor.new(0,0)
        
        pos_vector.x,pos_vector.y,vel_vector.x,vel_vector.y=
        bullet.pos_vector.x,bullet.pos_vector.y,bullet.velocity_vector.x,bullet.velocity_vector.y
        
        pos_vector = pos_vector+vel_vector
        x_0,y_0=pos_vector.x,pos_vector.y
        pos_vector = pos_vector+vel_vector
        x_1,y_1=pos_vector.x,pos_vector.y
       # puts "x_0: #{x_0}, y_0: #{y_0}, x_1: #{x_1}, y_1: #{y_1}"
		if x_0.floor != x_1.floor and y_0.floor != y_1.floor #prevent a lolsegmentation fault lol
			@surface.draw_line_a([x_1+SMALL_C,y_1+SMALL_C],[x_0+SMALL_C,y_0+SMALL_C],[255,255,255,255])
		end
      else
        @bullets.delete(bullet)
        puts "deleted"
      end  
      @surface.blit(onto,[0,0],@ob_rect)
     # @surface.update()
    }
  end
  
  def <<(bullet)
   self.add!(bullet)
  end
    
  def add!(bullet)
    @bullets << bullet
  end
  
  
  
end