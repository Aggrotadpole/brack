require("bin.npc")
require("bin.gstate")
require("bin.battlestate")

lvgp = lvgp or love.graphics
 local val = 0
platform = {}
 volume = 1
focusvar = love.window.hasMouseFocus()
scrw, scrh = lvgp.getDimensions()

function love.load()
	minimx = 736
	exitx = 768
	guiRender = true
	isPaused = false
	Pausable = true
	insertbool = insertbool or true
	window_x, window_y, window_d = love.window.getPosition( )
	window_w = 800
	window_h = 500
	window_scale = window_scale or 1
	game_w = game_w or window_w
	game_h = game_h or window_h
	game_scale = game_scale or 1
	esc_name = esc_name or 'def'
	esc_addr = 'assets/gfx/esc/' .. tostring(esc_name)
	banner = banner or lvgp.newImage(esc_addr .. '/banner.png')
	minimize = minimize or lvgp.newImage(esc_addr .. '/min.png')
	exitout = exitout or lvgp.newImage(esc_addr .. '/exit.png')
	icon = icon or lvgp.newImage(esc_addr .. '/icon.png')
	hpbar = hpbar or lvgp.newImage('assets/gfx/gui/btl/hp_bar.png')
	
	bstate = Gstate.New("bstate")
	currstate = bstate
	npc1 = Npc.New(2)
   npc1.desc = "An old man with a beard. His clothes seem otherworldly."
   npc1:AArray(npc1, 1, "Hello there!") 
   npc1:AArray(npc1, 2, "Well, goodbye now!")
   npc1.array = {"Look, it works!"}
	titleicon = love.image.newImageData('assets/title.png')
	canvas = bstate.canvas or lvgp.newCanvas(game_w*game_scale, game_h*game_scale,"normal",0)
	canvas:setFilter( "nearest", "nearest" )
	escvas = lvgp.newCanvas(window_w, window_h,"normal",0)
	escvas:setFilter( "nearest", "nearest" )
     
	
	love.window.setMode(window_w, window_h, {borderless=true, vsync=false})
	bstate.load()
end


 
function love.update(dt)
	--player.update()
 function saveClose(exitmode)
local mode = exitmode or "save"
if mode == "save" then
			local title = "Escape"
			local message = "Are you sure you want to leave?"
			local buttons = {"Yes","No",enterbutton = 2,escapebutton = 1}
 
			local pressedbutton = love.window.showMessageBox(title, message, buttons)
			if pressedbutton == 2 then
				isPaused = false
			elseif pressedbutton == 1 then
				love.event.quit()
			end
elseif mode == "exit" then
	love.event.quit()
elseif mode == "reset" then
	
end
end
if focusvar == true then
	--focusvar = 1
	titleicon:paste(love.image.newImageData('assets/title.png'), 0, 0)

end
if focusvar == false then
	--focusvar = 0
	titleicon:paste(love.image.newImageData('assets/title1.png'), 0, 0)
end
h = h or 1
hh = hh or 1
rot = rot or 0
function love.keypressed(key)
   if key == "insert" then
      insertbool = not insertbool
      love.mouse.setVisible(not love.mouse.isVisible())
	  guiRender = insertbool
   end
   if key == "home" then
      love.window.setPosition(0,0,1)
   end
   if key == "r" then
		h = h + 1
		end
	if key == "f" then
	h = h - 1
	end
	if key == "t" then
		hh = hh + 1
		end
	if key == "g" then
	hh = hh - 1
	end
	if key == "y" then
	rot = rot + 1/45
	end
	if key == "h" then
	rot = rot - 1/45
	end
	if key == "escape" then
		if Pausable == true then
		isPaused = not isPaused
		elseif isPaused == true then
		isPaused = false
		end
   end
end

	success = love.window.setIcon(titleicon)
	bstate.update()
	
	mx = tonumber(love.mouse.getX()/scrh*255)
	my = tonumber(love.mouse.getY()/scrh*255)
	
if love.mouse.getY() <= banner:getHeight() and love.mouse.getY() <= 32 and isPaused == true then
	bar_focus = true
	
	end
if  love.mouse.isDown(1) then
	minitX = minitX or love.mouse.getX()
	minitY = minitY or love.mouse.getY()
	bar_focus = bar_focus or false
	w_x,w_y= love.window.getPosition( )		
	
	
	
	if isPaused == true and bar_focus == true and (minitX ~= love.mouse.getX() or minitY ~= love.mouse.getY()) then
		if love.window.hasMouseFocus() then
		--love.mouse.setGrabbed(true)
		love.window.setPosition( w_x-(minitX-love.mouse.getX()), w_y-(minitY-love.mouse.getY()),1)	
		end
	
	else
	love.mouse.setGrabbed(false)
	end

else
	
	if bar_focus == true then
	minitX = love.mouse.getX()
	minitY = love.mouse.getY()
	if love.mouse.isGrabbed == true and isPaused == true then
	love.mouse.setGrabbed(false)
	end
	end
	
	end
function love.mousepressed(x, y, button, istouch)
   if button == 1 then
   if love.mouse.getX()  > minimx and love.mouse.getX() < minimx + minimize:getWidth() and isPaused == true and love.mouse.getY() <= banner:getHeight() then
	love.window.minimize()
	bar_focus = false
	end
	if love.mouse.getX()  > exitx and love.mouse.getX() < exitx + exitout:getWidth() and isPaused == true and love.mouse.getY() <= banner:getHeight() then
	saveClose("exit")
	bar_focus = false
	
	end
   end
end	
end
 
function love.draw()
	--player.draw()
	
	lvgp.setBackgroundColor(0,0,0)
	lvgp.setColor(255,255,255)
	
	lvgp.setCanvas(canvas)
	lvgp.setColor(love.mouse.getX(),10,10)
	lvgp.rectangle("fill", 0, 0, game_w*game_scale, game_h*game_scale)
	lvgp.setColor(255,255,255)
	bstate.draw()
	lvgp.circle('fill', love.mouse.getX(), love.mouse.getY(), h, hh)
	lvgp.setCanvas()
	if focusvar == true then
	titleicon:paste(love.image.newImageData('assets/title.png'), 0, 0)
	lvgp.print(esc_addr .. '/banner.png',16,16)
	end
	if focusvar == false then
	titleicon:paste(love.image.newImageData('assets/title1.png'), 0, 0)
	lvgp.print("npc.dialog[draw]: " .. tostring(npc1.array[1]), 16, 272)
	
	end
	lvgp.draw(canvas, 0, 0, rot, window_scale, window_scale)
	
	lvgp.setCanvas(escvas)
	if isPaused == true and Pausable == true then
	if not pausebg then
	lvgp.rectangle("fill",0,0,game_w*window_scale,game_h*window_scale)
	else
	lvgp.draw(pausebg,0,(banner:getHeight() or 32),window_scale)
	end
	lvgp.draw(banner,0,0,0,window_scale)
	lvgp.draw(minimize,736*window_scale,0,0,window_scale)
	lvgp.draw(exitout,768*window_scale,0,0,window_scale)
	lvgp.draw(icon,0,0,0,window_scale)
	end
	lvgp.setCanvas()
	if isPaused == true then
	lvgp.draw(escvas, 0, 0, 0, window_scale, window_scale)
	else
	if insertbool == true then
	edraw = lvgp.newQuad(10 + love.mouse.getX() / window_w * hpbar:getWidth(), 0, (1 - love.mouse.getX() / window_w) * hpbar:getWidth(), hpbar:getHeight(), hpbar:getWidth(), hpbar:getHeight())
	gdraw = lvgp.newQuad(0, 0, love.mouse.getX() / window_w * hpbar:getWidth(), hpbar:getHeight(), hpbar:getWidth(), hpbar:getHeight())
	lvgp.setColor(108,108,108,128)
	drawe = lvgp.draw(hpbar, edraw, 310 + love.mouse.getX() / window_w * hpbar:getWidth(), 100)
	drawg = lvgp.draw(hpbar, gdraw, 300, 100)
	lvgp.setColor(158,158,158,255)
	drawe = lvgp.draw(hpbar, edraw, 305 + love.mouse.getX() / window_w * hpbar:getWidth(), 90)
	lvgp.setColor(255,255,255,255)
	drawg = lvgp.draw(hpbar, gdraw, 295, 90)
	lvgp.print("HP%: " .. tostring(love.mouse.getX() / window_w * hpbar:getWidth()),305,90)
	end
	end
	
end