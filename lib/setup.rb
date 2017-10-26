WIDTH = 1024
HEIGHT = 768
class Setup
	def initialize
		@screen = Screen.new([WIDTH,HEIGHT],0,[Rubygame::HWSURFACE,Rubygame::DOUBLEBUF])
		@queue = Rubygame::EventQueue.new()
		@player = Player.new
		@control = Controller.new(@screen)
		
	end
	def run
		loop do
			@queue.each do |event|
				case event
					when Rubygame::QuitEvent
					 Rubygame.quit()
					 exit
					when Rubygame::KeyDownEvent
					 case event.key
					  when Rubygame::K_ESCAPE
					   puts "Oh Lawd"
					   Rubygame.quit()
					   exit
					  when Rubygame::K_RETURN
					   @control.run()
					 end 
				end			
			end
        end			
	end
	
end