require "rubygame/ftor"
class Theta
		def self.get(vector_1, vector_2) # usually player, mouse | player.vector - mouse.vector
			v1_minus_v2 = vector_1 - vector_2 #player.vector - mouse.vector
			v1_minus_v2.x += SMALL_C
			v1_minus_v2.y += SMALL_C
			mag_v1_v2 = v1_minus_v2.magnitude()
			adjacent = Ftor.new(vector_1.x,vector_1.y)
			adjacent.x = 0
			adjacent.y += SMALL_C if adjacent.y == 0
			c_projection = Gmath.mag_set(adjacent,v1_minus_v2)
			theta = Math.acos(c_projection.magnitude() / mag_v1_v2 )
			[theta, v1_minus_v2]
		end
	end
	
	class ThetaQuadrant < Theta #modify theta based on quadrant
		def self.get(vector_1,vector_2)
			theta,v1_minus_v2 = super
			#puts theta
			if v1_minus_v2.x > 0 and v1_minus_v2.y < 0
			#puts "a!"
			theta -= Math::PI
			theta *= -1
			elsif v1_minus_v2.x < 0 and v1_minus_v2.y > 0
			#puts "b!"
			theta *= -1
			theta -= 2 * Math::PI							
			elsif v1_minus_v2.x < 0 and v1_minus_v2.y < 0
			#puts "c!"
			theta -= Math::PI
			
			end
			return theta
		end	
	end
	
	class UnitVector < ThetaQuadrant
		def self.get(vector_1, vector_2)
			theta = super
			Ftor.new(-Math::sin(theta), -Math::cos(theta))
		end
	end