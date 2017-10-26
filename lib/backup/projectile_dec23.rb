require 'rubygame/ftor'

class Projectile
	SPEED = 10 #rate of change (speed and @vector = velocity)
	LIFE = 10
	INCREMENT = 20
	include Sprites::Sprite
	attr_accessor :vector
	def initialize(dir_ftor,loc_x, loc_y) # dir_ftor => unit vector of the direction
		@image = Rubygame::Surface.load('/rpong/lib/bullet.png')
		@orig_image = @image
		@velocity_vector = dir_ftor #velocity vector of the direction, only a unit vector at first
		
		@x,@y = loc_x,loc_y
		
		@pos_vector = Ftor.new(loc_x, loc_y) #position vector of the projectilt!!!!!!22
		
		@rect = @image.make_rect
		@rect.centerx,@rect.centery = loc_x,loc_y
		@groups = []
		@depth = 0
		#@image.centerx = loc_x
		#@image.centery = loc_y
		
	end	
	
	def speed=(rate_of_change) # distance/sec
		@velocity_vector.magnitude = rate_of_change #complete the definition of a velotity vector
	end
	
	def update
		#p @pos_vector
		#p @velocity_vector
		@pos_vector = @pos_vector + @velocity_vector #I think
		@x=@pos_vector.x
		@y=@pos_vector.y
		@rect.centerx = @x
		@rect.centery = @y
	end
	
end
		