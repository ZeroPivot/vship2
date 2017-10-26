require 'rubygame/ftor'
ROUNDS = 20

class Projectile
	RATE_OF_CHANGE = 5 #rate of change (speed and @vector = velocity) dfgdf
	
	OFFSET = 10
	THOUSAND_MILLISECONDS = 1000 
	LIFETIME = 20 * THOUSAND_MILLISECONDS #lifetime of a bullet in seconds (multiplied by a second in milliseconds)
	include Sprites::Sprite
	attr_accessor :pos_vector, :velocity_vector
	def initialize(dir_ftor,theta,loc_x, loc_y) # dir_ftor => unit vector in a direction (probably the ship's)
		@groups = []
		@depth = 0
		@alive = true
		@image = Rubygame::Surface.load('/vship/lib/bullet.png')
		@orig_image = @image
		@rect = @image.make_rect
		@velocity_vector = dir_ftor #velocity vector of the direction, only a unit vector at first		
		@pos_vector = Ftor.new(loc_x, loc_y) #position vector of the projectilt!!!!!!22
		offset = @velocity_vector
		offset.magnitude = OFFSET
		@pos_vector = @pos_vector + offset		
		@rect.centerx,@rect.centery = @pos_vector.x,@pos_vector.y
		
		rotate(theta)
		puts theta * 180.0/PI
		@last_theta = theta
		@life_clock = Clock.new()
		#@lifetime = LIFE		
		#@image.centerx = loc_x
		#@image.centery = loc_y
		
	end	
	
	def alive?
	  @alive
  end
	
	def speed=(rate_of_change) # distance/sec?
		@velocity_vector.magnitude = rate_of_change #complete the definition of a velocity vector?
	end
	
	#def speed+(amount)
	#	@velocity_vector.magnitude= @velocity.vector.magnitude() + amount
	#end
	
	def speed?
		@velocity_vector.magnitude()
	end
	
	def rotate(radians)
		last_x = @rect.centerx
		last_y = @rect.centery
		@image = @orig_image
		@image = @image.rotozoom(radians * 180/PI,1,true)
		@rect = @image.make_rect
		@pos_vector.x = @rect.centerx = last_x
		@pos_vector.y = @rect.centery = last_y	
	end
	
	def update
		#p @pos_vector
		#p @velocity_vector
		#puts @life_clock.tick()
		
		#### different functions
		#self.speed = 0.001+SMALL_C+((@life_clock.lifetime().to_f / 1000.0)**3.0)#self.speed? + RATE_OF_CHANGE
		#self.speed = 5+SMALL_C+(50*Math::sin(@life_clock.lifetime().to_f / 1000.0)**3.0)
		#self.speed = 5+SMALL_C+5*Math::sin(100*@life_clock.lifetime().to_f / 1000.0)
		self.speed = SMALL_C+Math::sqrt(Math::exp(@life_clock.lifetime().to_f / 1000.0))
		####
		#self.speed=15
		@pos_vector = @pos_vector + @velocity_vector #I think		
		@rect.centerx = @pos_vector.x
		@rect.centery = @pos_vector.y
		#puts "TIEM: #{@life_clock.lifetime()}"
		#puts "SPEED: #{self.speed?}"
		
		###### bullets that appear at the other side of the window
		#if @pos_vector.x < 0			
		#@rect.centerx =	@pos_vector.x = WIDTH			
		#elsif @pos_vector.x > WIDTH
		#@rect.centerx =	@pos_vector.x = 0				
		#end	
		#if @pos_vector.y > HEIGHT
		#@rect.centery =	@pos_vector.y = 0
		#elsif @pos_vector.y < 0	
		#@rect.centery =	@pos_vector.y = HEIGHT		
		#end	
		#####
		
		#### bullets that bounce back in a perpindicular direction (not very useful ####
		#if @pos_vector.x < 0 or @pos_vector.x > WIDTH or @pos_vector.y > HEIGHT or @pos_vector.y < 0
		#	@velocity_vector.angle=@velocity_vector.angle()+Math::PI
		#end
		if @pos_vector.x < 0 or @pos_vector.x > WIDTH or @pos_vector.y > HEIGHT or @pos_vector.y < 0
			@velocity_vector.angle=@velocity_vector.angle()+Math::PI/4			
			rotate(-@velocity_vector.angle-Math::PI/2)			
		end
		
		
		#self.kill 
		if @life_clock.lifetime() >= LIFETIME
		  @alive = false
		  self.kill
		end
		
		
	end
	
	#def remove(s)
	#	if @ready_for_death == true
	#		s.delete(self)
	#	end
	#end
	
	
end
		