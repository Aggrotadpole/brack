

playerChar = {
walkspeed = 1;
xsize = 32
ysize = 32
function load()
        -- This is the height and the width of the platform.
	--platform.width = love.graphics.getWidth()    -- This makes the platform as wide as the whole game window.
	--platform.height = love.graphics.getHeight()  -- This makes the platform as tall as the whole game window.  
 
        -- This is the coordinates where the platform will be rendered.
	--platform.x = 0                               -- This starts drawing the platform at the left edge of the game window.
	--platform.y = platform.height / 2             -- This starts drawing the platform at the very middle of the game window
	playerImg = love.graphics.newImage('assets/w16b16.png')
	src1 = love.audio.newSource("assets/music/test.wav") -- if "static" is omitted, LÖVE will stream the file from disk, good for longer music tracks
end
 
function update(dt)
if love.keyboard.isDown("m") then
		val = val+1
		if src1:getVolume() == 0 then
        volume = 1
		end
		if src1:getVolume() == 1 then
		volume = 0
		end
		src1:setVolume(volume) -- 0% of ordinary volume

    end
end
 
function draw()
	love.graphics.setColor(255, 255, 0)        -- This sets the platform color to white. (The parameters are in RGB Color format).
	love.graphics.draw(playerImg, 100, 100, 0, xsize, ysize, 0, 0)
end

function stripey( x, y, r, g, b, a )
   r = math.min(r * math.sin(x*100)*2, 255)
   g = math.min(g * math.cos(x*150)*2, 255)
   b = math.min(b * math.sin(x*50)*2, 255)
   return r,g,b,a
end

}
