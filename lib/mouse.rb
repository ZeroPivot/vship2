class Player_Mouse
	
	def initialize(x=0,y=0)
		@x,@y = x,y
		@vector = Ftor.new(x,y)		
	end
	
	
	def setx
	end
	
	def sety
	end
	
	def update(x, y)
		@x,@y = x,y
		@vector.x = x
		@vector.y = y
	end
	
	def vector
		@vector
	end
	
	def getx
		@x
	end
	
	def gety
		@y
	end
	
end