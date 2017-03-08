require("bin.gstate")

bgc = 0255, 0, 0
 
bstate = Gstate.New("Battle state")
 
function bstate.load()
    
end
 
function bstate.update(dt)
	
end
 
function bstate.draw()
	love.graphics.setBackgroundColor(bgc, 128)
	
end