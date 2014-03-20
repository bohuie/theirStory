local storyboard = require "storyboard"

-- set the background color to white  
-- local background = display.newRect( -70, 0, 1160, 768 )
-- background:setFillColor( 255, 255, 255 )  

myFont = "Comic Sans MS"
titleSize = 60
display.setDefault( "textColor", 251, 0, 160 )

storyboard.gotoScene( "menu" )

-- function profiles()
--   display.remove( menuGrp )
--   display.newText( "under construction", 240, 320, myFont, titleSize )
-- end
-- 
-- function credits()
--   display.remove( menuGrp )
--   display.newText( "under construction", 240, 320, myFont, titleSize )
-- end
-- 
-- function games()
--   display.remove( menuGrp )
--   txt = display.newText( "under construction", 240, 320, myFont, titleSize )
--   home = display.newImage( "home.png", 430, 410 )
--   home:addEventListener( "tap", main )
--   -- gamesGrp:insert( txt )
--   -- gamesGrp:insert( home )
-- end
-- 
-- function comics()
--   display.remove( menuGrp )
--   c1 = display.newImage( "sleeping_with_casper1.png", 400, 250 ) 
--   comicsGrp:insert( c1 )
-- end
-- 
-- main()
