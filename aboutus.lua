local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- forward declarations and other locals
local nextButton, panel1, panel2, panel3, panel4
local background, pageTween

local swipeThresh = 100		-- amount of pixels finger must travel to initiate page swipe
local tweenTime = 500
local readyToContinue = false

-- function to show next panel within a comic
local function showNext()
  print( "inside showNext" )
	if readyToContinue then
		nextButton.isVisible = false
		readyToContinue = false
		
		local function completeTween()
			readyToContinue = true
			nextButton.isVisible = true
		end
		
    print( "inside showNext: panel1" )
		panel4.isVisible = false
		panel1.alpha = 1
		panel1.x = -panel1.contentWidth
		panel1.isVisible = true
		pageTween = transition.to( panel1, { time=tweenTime, x=display.contentWidth*0.5, transition=easing.outExpo, onComplete=completeTween } )
	end
end

-- touch event listener for background object
local function onPageSwipe( self, event )
	local phase = event.phase
	if phase == "began" then
		display.getCurrentStage():setFocus( self )
		self.isFocus = true
	
	elseif self.isFocus then
		if phase == "ended" or phase == "cancelled" then
			
			local distance = event.x - event.xStart
			if distance > swipeThresh then
				-- SWIPED to right; go back to title page scene
				storyboard.gotoScene( "menu", "slideRight", 800 )
			else
				-- Touch and release; initiate next panel
				showNext()
			end
			
			display.getCurrentStage():setFocus( nil )
			self.isFocus = nil
		end
	end
	return true
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-- create background image
  background = display.newImageRect( group, "white.png", 600, 400 )
  background:scale( 3.65, 3.85 )
  background.alpha = 1
	
	-- create panels
	panel1 = display.newImageRect( group, "sleeping_with_casper1.png", 600, 600 )
  panel1:scale( 1.25, 1.25 )
	panel1:setReferencePoint( display.CenterReferencePoint )
	panel1.x = display.contentWidth * 0.5
	panel1.y = display.contentHeight * 0.5
	panel1.isVisible = false
	
	panel2 = display.newImageRect( group, "sleeping_with_casper2.png", 600, 600 )
  panel2:scale( 1.25, 1.25 )
	panel2:setReferencePoint( display.CenterReferencePoint )
	panel2.x = display.contentWidth * 0.5
	panel2.y = display.contentHeight * 0.5
	panel2.isVisible = false
	
	panel3 = display.newImageRect( group, "sleeping_with_casper3.png", 600, 600 )
  panel3:scale( 1.25, 1.25 )
	panel3:setReferencePoint( display.CenterReferencePoint )
	panel3.x = display.contentWidth * 0.5
	panel3.y = display.contentHeight * 0.5
	panel3.isVisible = false
	
	panel4 = display.newImageRect( group, "sleeping_with_casper4.png", 600, 600 )
  panel4:scale( 1.25, 1.25 )
	panel4:setReferencePoint( display.CenterReferencePoint )
	panel4.x = display.contentWidth * 0.5
	panel4.y = display.contentHeight * 0.5
	panel4.isVisible = false
	
	-- create buttons
	nextButton = display.newImageRect( group, "paw_right.png", 170, 149 )
	nextButton:setReferencePoint( display.CenterReferencePoint )
	nextButton.x = display.contentWidth - 50
	nextButton.y = display.contentHeight - 80
	nextButton.isVisible = false
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	panel = 1
	readyToContinue = true
	showNext()
	
	-- assign touch event to buttons
	nextButton.touch = onPageSwipe
	nextButton:addEventListener( "touch", nextButton )
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-- hide objects
	panel1.isVisible = false
	panel2.isVisible = false
	panel3.isVisible = false
	panel4.isVisible = false
	
	-- remove touch event listener for background
	-- background:removeEventListener( "touch", background )
	
	-- cancel page animations (if currently active)
	if pageTween then transition.cancel( pageTween ); pageTween = nil; end
	-- if fadeTween1 then transition.cancel( fadeTween1 ); fadeTween1 = nil; end
	-- if fadeTween2 then transition.cancel( fadeTween2 ); fadeTween2 = nil; end
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	-- INSERT code here (e.g. remove listeners, remove widgets, save state variables, etc.)
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene

