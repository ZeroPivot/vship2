require 'rubygame/ftor'
PI = Math::PI
class Player
	#include Rubygame
	include Sprites::Sprite
	attr_accessor :dirx,:diry,:keydown, :vector,:self
	
	SPEED = 5
	
	def initialize(s=nil)		
		@image = Rubygame::Surface.load('/vship/lib/player.png')
		@orig_image = @image
		@rect = @image.make_rect
		@dirx = 0 # => 0 == not moving, @dir < =
		@diry = 0
		@keydown = false
		@lastKey = nil
		@dirBit = 0
		@vector = Ftor.new(0, 0) #position vector	
		@groups = [] #let this be a sprite
		@depth = 0
		#@last_image = nil
		#@rect.center = [320,450]
	end
	
	def flip(horiz,vert)
		last_x = @rect.centerx
		last_y = @rect.centery
		@image = @image.flip(horiz,vert)
		@rect = @image.make_rect
		@rect.centerx = last_x
		@rect.centery = last_y
	end

	
	def rotate(degrees)
		last_x = @rect.centerx
		last_y = @rect.centery
		@image = @orig_image
		@image = @image.rotozoom(degrees * 180/PI,1,true)
		@rect = @image.make_rect
		@vector.x = @rect.centerx = last_x
		@vector.y = @rect.centery = last_y	
	end
	
	
	
	def lastKey(lastKey)	
		@lastKey = lastKey
		#puts @lastKey
		#return @lastKey if lastKey==nil
	end
	
	def lastKey?
		@lastKey
	end
	
	
	def dirBits!(mod)
		@dirBit = mod
	end
	
	def dirBits?
		@dirBit
	end
	
	
	
	def place(a,b)
		@rect.center = [a,b]
		@vector.x = @rect.centerx
		@vector.y = @rect.centery
	end
	
	
	def centerx
		@rect.centerx
	end
	
	def centery
		@rect.centery
	end
	
	def centerx=(x)
		@rect.centerx = x
		@vector.x = @rect.centerx
	end
	
	def centery=(y)
		@rect.centery = y
		@vector.y = @rect.centery
	end
	
	
	def updatex(delta)
		#if @dirx <= 100
		@rect.centerx += (SPEED * delta * @dirx)
		@vector.x = @rect.centerx
		#else
		#@rect.centerx += (SPEED * delta)
		#end
		#puts @rect.centerx
	end
	
	def updatey(delta)
		#i#f @diry <= 100
		@rect.centery += (SPEED * delta * @diry)
		@vector.y = @rect.centery
		#else
		#@rect.centery += (SPEED * delta)
		#end
		#puts @rect.centery
	end
	
end