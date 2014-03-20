local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local background
local opt1
local opt2
local opt3
local opt4

local function onAboutTouch( self, event )
  if event.phase == "ended" or event.phase == "cancelled" then
		storyboard.gotoScene( "aboutus", "slideLeft", 800 )
		return true	-- indicates successful touch
	end
end

local function onComicsTouch( self, event )
  if event.phase == "ended" or event.phase == "cancelled" then
		storyboard.gotoScene( "comics", "slideLeft", 800 )
		return true	-- indicates successful touch
	end
end

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

  background = display.newImageRect( group, "white.png", 600, 400 )
  background:scale( 3.65, 3.85 )
  background.alpha = 1

  local banner = display.newImageRect( group, "banner.png", 1814, 236 )
  banner:scale( 0.65, 0.65 )
  banner:setReferencePoint( display.TopLeftReferencePoint )
	banner.x, banner.y = -80, 50

  local footer = display.newImageRect( group, "footer.png", 685, 277 )
  footer:scale( 1.20, 1.20 )
	footer.x = display.contentWidth / 2
  footer.y = 590
  opt1 = display.newImage( "paw.png", 20,  200 ) 
  opt2 = display.newImage( "paw.png", 20,  300 ) 
  opt3 = display.newImage( "paw.png", 500, 200 ) 
  opt4 = display.newImage( "paw.png", 500, 300 ) 
  opt1:scale( 0.40, 0.40 )
  opt2:scale( 0.40, 0.40 )
  opt3:scale( 0.40, 0.40 )
  opt4:scale( 0.40, 0.40 )
  local txt1 = display.newText( "Profiles", 160, 210, myFont, titleSize )
  local txt2 = display.newText( "About Us", 160, 310, myFont, titleSize )
  local txt3 = display.newText( "Games",    640, 210, myFont, titleSize )
  local txt4 = display.newText( "Comics",   640, 310, myFont, titleSize )

  group:insert( banner )
  group:insert( footer )
  group:insert( opt1 )
  group:insert( opt2 )
  group:insert( opt3 )
  group:insert( opt4 )
  group:insert( txt1 )
  group:insert( txt2 )
  group:insert( txt3 )
  group:insert( txt4 )
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-- opt1.touch = onProfilesTouch
  -- opt1:addEventListener( "touch", opt1 )
	opt2.touch = onAboutTouch
  opt2:addEventListener( "touch", opt2 )
	-- opt3.touch = onGamesTouch
  -- opt3:addEventListener( "touch", opt3 )
	opt4.touch = onComicsTouch
  opt4:addEventListener( "touch", opt4 )
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
  background:removeEventListener( "touch", background )
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene

