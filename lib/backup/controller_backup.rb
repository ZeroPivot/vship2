class Controller
	def initialize(screen)
		@screen = screen
		@background = Rubygame::Surface.load("/rpong/lib/background.png")
		@player = Player.new
		@queue = Rubygame::EventQueue.new()
		@clock = Rubygame::Clock.new()
		@clock.target_framerate = 60
		@player.place(250,250)
		
	end
	
	def fps_update()
		@screen.title = "FPS: #{@clock.framerate()}"
	end
	
	def run
		loop do
			@queue.each do |event|
			 case event
				when Rubygame::QuitEvent
					Rubygame.quit()
					exit
				when Rubygame::KeyDownEvent
					#if @player.keydown == false
						@player.keydown = true
						case event.key
						when Rubygame::K_ESCAPE
							Rubygame.quit()
							exit
						when Rubygame::K_RETURN
							puts "lol"
						when Rubygame::K_LEFT
							@player.dirx -= 1
							@player.lastKey(Rubygame::K_LEFT)
						when Rubygame::K_RIGHT
							@player.dirx += 1
							@player.lastKey(Rubygame::K_RIGHT)
						when Rubygame::K_UP
							@player.diry -= 1
						when Rubygame::K_DOWN
							@player.diry += 1
						end
					#end
				
				when Rubygame::KeyUpEvent
					@player.keydown = false
					@player.lastKey nil
					#case event.key
					# when Rubygame::K_LEFT
						#@player.dir += 1
					#	@player.lastKey nil
					# when Rubygame::K_RIGHT
						#@player.dir -= 1
					#	@player.lastKey nil
					# when Rubygame::K_UP
					#	@player
					#end
				end
			end
		
			fps_update()
			@background.blit(@screen,[0,0])
			
			case @player.keydown
				when true
					if @player.lastKey? != nil
					case @player.lastKey?
						when Rubygame::K_LEFT
							@player.dirx -= 1
						when Rubygame::K_RIGHT
							@player.dirx += 1
						when Rubygame::K_UP
							@player.diry -= 1
						when Rubygame::K_DOWN
							@player.diry += 1
					end
					end					
					
				when false
					if @player.dirx > 0
						@player.dirx -= 1
					elsif @player.dirx < 0
						@player.dirx += 1
					end
					
					if @player.diry > 0
						@player.diry -= 1
					elsif @player.diry < 0
						@player.diry += 1
					end
					
			end
						
			
			
			#if @player.keydown == true and @player.lastKey? != nil
			#	case @player.lastKey?
			#		when Rubygame::K_LEFT
			#			@player.dir -= 1
			#		when Rubygame::K_RIGHT
			#			@player.dir += 1
			#	end
				#puts Rubygame::K_LEFT
			#end
			@player.draw(@screen)			
			@screen.update			
			@player.updatex(@clock.tick*0.001)
			@player.updatey(@clock.tick*0.001)
		end
	end
end