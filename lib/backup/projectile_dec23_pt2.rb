require 'rubygame/ftor'

class Projectile
	SPEED = 10 #rate of change (speed and @vector = velocity)
	LIFE = 10
	INCREMENT = 1
	ONE_SECOND = 1000
	TWO_SECONDS = 1000 + 4000
	include Sprites::Sprite
	attr_accessor :vector
	def initialize(dir_ftor,loc_x, loc_y) # dir_ftor => unit vector of the direction
		@image = Rubygame::Surface.load('/rpong/lib/bullet.png')
		@orig_image = @image
		@rect = @image.make_rect
		@velocity_vector = dir_ftor #velocity vector of the direction, only a unit vector at first		
		@pos_vector = Ftor.new(loc_x, loc_y) #position vector of the projectilt!!!!!!22
		offset = @velocity_vector
		offset.magnitude = INCREMENT
		@pos_vector = @pos_vector + offset		
		@rect.centerx,@rect.centery = @pos_vector.x,@pos_vector.y	
		@groups = []
		@depth = 0
		@life_clock = Clock.new()
		#@lifetime = LIFE
		@ready_for_death = false
		#@image.centerx = loc_x
		#@image.centery = loc_y
		
	end	
	
	def speed=(rate_of_change) # distance/sec
		@velocity_vector.magnitude = rate_of_change #complete the definition of a velotity vector
	end
	
	#def speed+(amount)
	#	@velocity_vector.magnitude= @velocity.vector.magnitude() + amount
	#end
	
	def speed?
		@velocity_vector.magnitude()
	end
	
	def update
		#p @pos_vector
		#p @velocity_vector
		
		@pos_vector = @pos_vector + @velocity_vector #I think		
		@rect.centerx = @pos_vector.x
		@rect.centery = @pos_vector.y
		#puts "TIEM: #{@life_clock.lifetime()}"
		self.kill if @life_clock.lifetime() >= TWO_SECONDS
		
		
	end
	
	#def remove(s)
	#	if @ready_for_death == true
	#		s.delete(self)
	#	end
	#end
	
	
end
		