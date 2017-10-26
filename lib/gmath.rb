#shitty math library
module Gmath

	def angle_between(coord_a, coord_b)
		a_dot_b = coord_a[0]*coord_b[0] + coord_a[1]*coord_b[1]
		mag_a = Math.sqrt(coord_a[0] ** 2 + coord_a[1] ** 2)
		mag_b = Math.sqrt(coord_b[0] ** 2 + coord_b[1] ** 2)
		theta = Math.acos(a_dot_b / (mag_a * mag_b))
	
	end
	
	def projection?(v_a, v_b) # of v[ector]_a onto v[ector]_b
		dot = v_a.dot(v_b)
		mag = v_b.magnitude().to_f ** 2
		d_mag = dot.to_f / mag.to_f
		v_b * d_mag				
	end
	
	def mag_set(a,b)
		Ftor.new(a.x/a.magnitude(),a.y/a.magnitude()) * b #direction of a			
	end

end

	