require "lib/gmath.rb"
require "lib/mouse.rb"
include Gmath
LEFT = 0x8
RIGHT = 0x4
UP = 0x2
DOWN = 0x1

class Controller
	def initialize(screen)
		@screen = screen
		@background = Rubygame::Surface.load("/rpong/lib/background.png")
		@player = Player.new
		@queue = Rubygame::EventQueue.new()
		@clock = Rubygame::Clock.new()
		@clock.target_framerate = 60
		@player.place(250,250)
		@m_vector = Ftor.new(0,0)
		
		
	end
	
	#def putsd
	
	def fps_update()
		@screen.title = "FPS: #{@clock.framerate()}"
	end
	
	def updateMousePos
	end
	
	def run
		loop do
			@queue.each do |event|
			 case event
				when Rubygame::MouseMotionEvent
					#puts "mouse move!"
					#puts event.pos
					@m_vector.x = event.pos[0]
					@m_vector.y = event.pos[1]
					puts "Player: #{@player.vector.angle * 180 / Math::PI}"
					puts "Mouse: #{@m_vector.angle * 180 / Math::PI}"
					#c = Gmath.projection?(@player.vector, @m_vector)
					#puts c
					#@player.vector.unit = @m_vector
					#puts "Angle: #{c.angle * 180 / Math::PI}"
					ship_minus_mouse = @player.vector - @m_vector #quadrant test
					ship_minus_mouse.x += 0.000000001 # sometimes it's 0 ...
					ship_minus_mouse.y += 0.000000001 #
					
					
					mag_ship_and_mouse = ship_minus_mouse.magnitude()
					adjacent = @player.vector
					adjacent.x = 0
					#adjacent.y = adjacent.y
					#c = Gmath.projection?(ship_minus_mouse, adjacent) # == I really liked my projection too ... precision error due to too much division, though
					c = Gmath.mag_set(adjacent, ship_minus_mouse) #should be a little faster
					puts c.x
					puts c.y
					###c.y = c.y.abs
					#c = Ftor.new(0,adjacent.y)
					#y = c
					#y.magnitude = ship_minus_mouse
					y = Gmath.projection?(ship_minus_mouse, adjacent)
					y.magnitude = ship_minus_mouse
					
					#c.magnitude=ship_minus_mouse
					
					#if mag_ship_and_mouse == c.magnitude
					#	mag_ship_and_mouse += 0.00000000001 #LOL!
					#end
					#c=Ftor.new(0,adjacent.y)
					puts "MAG CP: #{c.magnitude()}"
					
					
					#c.magnitude=ship_minus_mouse					
					#puts "MAG CP1: #{c.magnitude()}"					
					puts "MAG C: #{c.magnitude()}"
					puts "MAG Y: #{y.magnitude()}"
				
					puts c.magnitude() <=> y.magnitude()
					puts c.magnitude() - y.magnitude()
					t = Ftor.new(5,0)
					g = Ftor.new(7,6)
					t.magnitude=g
					puts t.x
					puts t.y
					puts g.magnitude()
					puts t.magnitude()
					theta = Math.acos( c.magnitude() / mag_ship_and_mouse )
					puts "THETA: #{theta * 180 / Math::PI}"
					if ship_minus_mouse.x > 0 and ship_minus_mouse.y < 0
						puts "a!"
						theta -= Math::PI
						theta *= -1
					elsif ship_minus_mouse.x < 0 and ship_minus_mouse.y > 0
						puts "b!"
						theta *= -1
						theta -= 2 * Math::PI	
						
					elsif ship_minus_mouse.x < 0 and ship_minus_mouse.y < 0
						puts "c!"
						theta -= Math::PI
						
					end					
					@player.rotate(theta)
					
					theta = Math.acos( (c.magnitude()/ mag_ship_and_mouse) )		
				
				when Rubygame::QuitEvent
					Rubygame.quit()
					exit
				when Rubygame::KeyDownEvent				
						@player.keydown = true
						case event.key
						when Rubygame::K_ESCAPE
							Rubygame.quit()
							exit
						when Rubygame::K_RETURN
							puts "lol"
						when Rubygame::K_LEFT							
							@player.dirBits!(LEFT | @player.dirBits?)
						when Rubygame::K_RIGHT							
							@player.dirBits!(RIGHT | @player.dirBits?)
						when Rubygame::K_UP							
							@player.dirBits!(UP | @player.dirBits?)
						when Rubygame::K_DOWN
							@player.dirBits!(DOWN | @player.dirBits?)
						end			
				
				when Rubygame::KeyUpEvent
					@player.keydown = false
					@player.lastKey nil
					case event.key
					 when Rubygame::K_LEFT
						@player.dirBits!(LEFT ^ @player.dirBits?)				
					 when Rubygame::K_RIGHT
						@player.dirBits!(RIGHT ^ @player.dirBits?)					
					 when Rubygame::K_UP
						@player.dirBits!(UP ^ @player.dirBits?)					 
					 when Rubygame::K_DOWN
						@player.dirBits!(DOWN ^ @player.dirBits?)				
				end
			end
		end
			fps_update()
			@background.blit(@screen,[0,0])
			
			if @player.dirBits? > 0
				case @player.dirBits?
					when UP | LEFT
						@player.dirx -= 1
						@player.diry -= 1
					when UP | RIGHT
						@player.dirx += 1
						@player.diry -= 1
					when DOWN | LEFT
						@player.dirx -= 1
						@player.diry += 1
					when DOWN | RIGHT
						@player.dirx += 1
						@player.diry += 1
					when UP
						@player.diry -= 1
					when DOWN
						@player.diry += 1
					when LEFT
						@player.dirx -= 1
					when RIGHT
						@player.dirx += 1					
				end
				
			elsif (@player.dirx.abs > 0 || @player.diry.abs > 0)
				if @player.dirx < 0
					@player.dirx += 1
				elsif @player.dirx > 0
					@player.dirx -= 1
				end
				
				if @player.diry < 0
					@player.diry += 1
				elsif @player.diry > 0
					@player.diry -= 1
				end
			end
			
			
				if @player.centerx < 0
					@player.centerx = 638
				elsif @player.centerx > 640
					@player.centerx = 0
				end	
				if @player.centery > 480
					@player.centery = 0
				elsif @player.centery < 0
					@player.centery = 480
				end
			

			
			#puts @player.dirBits?
			
			@player.draw(@screen)			
			@screen.update			
			@player.updatex(@clock.tick*0.001)
			@player.updatey(@clock.tick*0.001)
		end
	end
end