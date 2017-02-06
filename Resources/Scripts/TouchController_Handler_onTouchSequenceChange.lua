--------------------------------------------------------------------------------
--  Handler.......... : onTouchSequenceChange
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function TouchController.onTouchSequenceChange ( nTaps0, nX0, nY0, nTaps1, nX1, nY1, nTaps2, nX2, nY2, nTaps3, nX3, nY3, nTaps4, nX4, nY4 )
--------------------------------------------------------------------------------
	
    -- exit immediately if not active
    if this._bAI ( ) == false then
        return
    end

    -- turn nTaps number into a boolean
    local bTaps0 = nTaps0 and nTaps0 > 0
    local bTaps1 = nTaps1 and nTaps1 > 0
    local bTaps2 = nTaps2 and nTaps2 > 0
    local bTaps3 = nTaps3 and nTaps3 > 0
    local bTaps4 = nTaps4 and nTaps4 > 0

    -- Convert touch coords to HUD coords
    if ( bTaps0 ) then nX0 = 50 * ( nX0 + 1 ) nY0 = 50 * ( nY0 + 1 ) end
    if ( bTaps1 ) then nX1 = 50 * ( nX1 + 1 ) nY1 = 50 * ( nY1 + 1 ) end
    if ( bTaps2 ) then nX2 = 50 * ( nX2 + 1 ) nY2 = 50 * ( nY2 + 1 ) end
    if ( bTaps3 ) then nX3 = 50 * ( nX3 + 1 ) nY3 = 50 * ( nY3 + 1 ) end 
    if ( bTaps4 ) then nX4 = 50 * ( nX4 + 1 ) nY4 = 50 * ( nY4 + 1 ) end

    
    -- cache values
    local f     = this._bForward ( )
    local hU    = this.getUser ( )
    local sAI   = this.sTargetAIModel ( )
    local tB    = this._tButtonStates ( )
    local nB    = this.nActionButtons ( )
    local nA    = application.getCurrentUserViewportAspectRatio ( )
    
    
    
    ---------------------------------------
    -- generic button loop
    
    for i=0, nB-1 do
        local hButton = hud.getComponent ( hU, "TC.Button"..i )
        
        if hButton ~= nil then
        
            local nButtonMinX, nButtonMinY = hud.getComponentScreenSpaceBottomLeftCorner ( hButton )
            local nButtonMaxX, nButtonMaxY = hud.getComponentScreenSpaceTopRightCorner   ( hButton )
            

            -- check component for each tap to see if a button was hit:
            -- loop unrolled on purpose, since you will most likely only have 2-3 fingers on the screen
            -- so running all 5 checks every time would be a waste
            
            if ( bTaps0 and this.isUnderComponent ( nX0, nY0, nButtonMinX, nButtonMinY, nButtonMaxX, nButtonMaxY ) ) then
                if ( not table.getAt ( tB, i ) ) then
                    if f then user.sendEventImmediate ( hU, sAI, "onJoypadButtonDown", 0, i ) end
                    table.setAt ( tB, i, true )
                    hud.stopAction ( hU, "TC_onFlashButton"..i ); hud.callAction ( hU, "TC_onFlashButton"..i )
                end
                bTaps0 = false
                
            elseif ( bTaps1 and this.isUnderComponent ( nX1, nY1, nButtonMinX, nButtonMinY, nButtonMaxX, nButtonMaxY ) ) then
                if ( not table.getAt ( tB, i ) ) then
                    if f then user.sendEventImmediate ( hU, sAI, "onJoypadButtonDown", 0, i ) end
                    table.setAt ( tB, i, true )
                    hud.stopAction ( hU, "TC_onFlashButton"..i ); hud.callAction ( hU, "TC_onFlashButton"..i )
                end
                bTaps1 = false
                
            elseif ( bTaps2 and this.isUnderComponent ( nX2, nY2, nButtonMinX, nButtonMinY, nButtonMaxX, nButtonMaxY ) ) then
                if ( not table.getAt ( tB, i ) ) then
                    if f then user.sendEventImmediate ( hU, sAI, "onJoypadButtonDown", 0, i ) end
                    table.setAt ( tB, i, true )
                    hud.stopAction ( hU, "TC_onFlashButton"..i ); hud.callAction ( hU, "TC_onFlashButton"..i )
                end
                bTaps2 = false
                
            elseif ( bTaps3 and this.isUnderComponent ( nX3, nY3, nButtonMinX, nButtonMinY, nButtonMaxX, nButtonMaxY ) ) then
                if ( not table.getAt ( tB, i ) ) then
                    if f then user.sendEventImmediate ( hU, sAI, "onJoypadButtonDown", 0, i ) end
                    table.setAt ( tB, i, true )
                    hud.stopAction ( hU, "TC_onFlashButton"..i ); hud.callAction ( hU, "TC_onFlashButton"..i )
                end
                bTaps3 = false
                
            elseif ( bTaps4 and this.isUnderComponent ( nX4, nY4, nButtonMinX, nButtonMinY, nButtonMaxX, nButtonMaxY ) ) then
                if ( not table.getAt ( tB, i ) ) then
                    if f then user.sendEventImmediate ( hU, sAI, "onJoypadButtonDown", 0, i ) end
                    table.setAt ( tB, i, true )
                    hud.stopAction ( hU, "TC_onFlashButton"..i ); hud.callAction ( hU, "TC_onFlashButton"..i )
                end
                bTaps4 = false
                
            -- otherwise button was pressed and you need to un-press it
            else
                if ( table.getAt ( tB, i ) ) then
                    if f then user.sendEventImmediate ( hU, sAI, "onJoypadButtonUp", 0, i ) end
                    table.setAt ( tB, i, false )
                end
            end
            
        end -- valid button end
    end -- for end
    
    
    
    ---------------------------------------
    -- sticks
    
    -- stick components
    local hStick0Back   = hud.getComponent ( hU, "TC.Stick0Back" )
    local hStick0Thumb  = hud.getComponent ( hU, "TC.Stick0Thumb" )
    local hStick1Back   = hud.getComponent ( hU, "TC.Stick1Back" )
    local hStick1Thumb  = hud.getComponent ( hU, "TC.Stick1Thumb" )   
    
    -- stick coordinates
    local nStick0BackMinX, nStick0BackMinY
    local nStick0BackMaxX, nStick0BackMaxY     
    local nStick1BackMinX, nStick1BackMinY
    local nStick1BackMaxX, nStick1BackMaxY
    
    -- stick cached values
    local ts0c = this._tStick0C ( )
    local ts0l = this._tStick0L ( )
    local ts1c = this._tStick1C ( )
    local ts1l = this._tStick1L ( )
    
    
    -- stick loops

    -- left
    if ( hStick0Back ) then
        nStick0BackMinX, nStick0BackMinY = hud.getComponentScreenSpaceBottomLeftCorner ( hStick0Back )
        nStick0BackMaxX, nStick0BackMaxY = hud.getComponentScreenSpaceTopRightCorner   ( hStick0Back )
        
        local sX        = 0.5 * ( nStick0BackMaxX - nStick0BackMinX )
        local sY        = 0.5 * ( nStick0BackMaxY - nStick0BackMinY )
        local cX        = 0.5 * ( nStick0BackMaxX + nStick0BackMinX )
        local cY        = 0.5 * ( nStick0BackMaxY + nStick0BackMinY )
        local dX, dY    = 0
        
        local tcX = table.getAt ( ts0c, 0 )
        local tcY = table.getAt ( ts0c, 1 )
        local tlX = table.getAt ( ts0l, 0 )
        local tlY = table.getAt ( ts0l, 1 )
        
        
        if ( this._bTrackingStick0 ( ) ) then
        
            if ( bTaps0 and math.vectorLength ( nX0 - tlX, nY0 - tlY, 0 ) < 25 ) then
                dX,dY = this._dxdy ( nX0,nY0, cX,cY, tcX,tcY, sX,sY, nA )
                user.sendEventImmediate ( hU, sAI, "onJoypadStickMove", 0, 0, 1.43*dX/sX, 1.43*dY/sY ) -- 1/0.7=1.43 as factor because we have applied a factor of 0.7 in _dxdy
                hud.setComponentPosition ( hStick0Thumb, cX + dX, cY + dY )
                table.setAt ( ts0l, 0, nX0 ); table.setAt ( ts0l, 1, nY0 )
                bTaps0 = false
                
                
            elseif ( bTaps1 and math.vectorLength ( nX1 - tlX, nY1 - tlY, 0 ) < 25 ) then
                dX,dY = this._dxdy ( nX1,nY1, cX,cY, tcX,tcY, sX,sY, nA )
                user.sendEventImmediate ( hU, sAI, "onJoypadStickMove", 0, 0, 1.43*dX/sX, 1.43*dY/sY )
                hud.setComponentPosition ( hStick0Thumb, cX + dX, cY + dY )
                table.setAt ( ts0l, 0, nX1 ); table.setAt ( ts0l, 1, nY1 )
                bTaps1 = false
                
                
            elseif ( bTaps2 and math.vectorLength ( nX2 - tlX, nY2 - tlY, 0 ) < 25 ) then
                dX,dY = this._dxdy ( nX2,nY2, cX,cY, tcX,tcY, sX,sY, nA )
                user.sendEventImmediate ( hU, sAI, "onJoypadStickMove", 0, 0, 1.43*dX/sX, 1.43*dY/sY )
                hud.setComponentPosition ( hStick0Thumb, cX + dX, cY + dY )
                table.setAt ( ts0l, 0, nX2 ); table.setAt ( ts0l, 1, nY2 )
                bTaps2 = false
                
                
            elseif ( bTaps3 and math.vectorLength ( nX3 - tlX, nY3 - tlY, 0 ) < 25 ) then
                dX,dY = this._dxdy ( nX3,nY3, cX,cY, tcX,tcY, sX,sY, nA )
                user.sendEventImmediate ( hU, sAI, "onJoypadStickMove", 0, 0, 1.43*dX/sX, 1.43*dY/sY )
                hud.setComponentPosition ( hStick0Thumb, cX + dX, cY + dY )
                table.setAt ( ts0l, 0, nX3 ); table.setAt ( ts0l, 1, nY3 )
                bTaps3 = false


            elseif ( bTaps4 and math.vectorLength ( nX4 - tlX, nY4 - tlY, 0 ) < 25 ) then
                dX,dY = this._dxdy ( nX4,nY4, cX,cY, tcX,tcY, sX,sY, nA )
                user.sendEventImmediate ( hU, sAI, "onJoypadStickMove", 0, 0, 1.43*dX/sX, 1.43*dY/sY )
                hud.setComponentPosition ( hStick0Thumb, cX + dX, cY + dY )
                table.setAt ( ts0l, 0, nX4 ); table.setAt ( ts0l, 1, nY4 )
                bTaps4 = false
                
            else
                -- reset stick
                user.sendEventImmediate ( hU, sAI, "onJoypadStickMove", 0, 0, 0, 0 )
                this._bTrackingStick0 ( false )
                hud.matchComponentScreenSpaceCenter ( hStick0Thumb, hStick0Back )
            end
            
        
        else
        
            if ( bTaps0 and this.isUnderComponent ( nX0, nY0, nStick0BackMinX, nStick0BackMinY, nStick0BackMaxX, nStick0BackMaxY ) ) then
                table.setAt ( ts0c, 0, nX0 ); table.setAt ( ts0c, 1, nY0 )
                table.setAt ( ts0l, 0, nX0 ); table.setAt ( ts0l, 1, nY0 )
                this._bTrackingStick0 ( true )
                
            elseif ( bTaps1 and this.isUnderComponent ( nX1, nY1, nStick0BackMinX, nStick0BackMinY, nStick0BackMaxX, nStick0BackMaxY ) ) then
                table.setAt ( ts0c, 0, nX1 ); table.setAt ( ts0c, 1, nY1 )
                table.setAt ( ts0l, 0, nX1 ); table.setAt ( ts0l, 1, nY1 )
                this._bTrackingStick0 ( true )

            elseif ( bTaps2 and this.isUnderComponent ( nX2, nY2, nStick0BackMinX, nStick0BackMinY, nStick0BackMaxX, nStick0BackMaxY ) ) then
                table.setAt ( ts0c, 0, nX2 ); table.setAt ( ts0c, 1, nY2 )
                table.setAt ( ts0l, 0, nX2 ); table.setAt ( ts0l, 1, nY2 )
                this._bTrackingStick0 ( true )
                
            elseif ( bTaps3 and this.isUnderComponent ( nX3, nY3, nStick0BackMinX, nStick0BackMinY, nStick0BackMaxX, nStick0BackMaxY ) ) then
                table.setAt ( ts0c, 0, nX3 ); table.setAt ( ts0c, 1, nY3 )
                table.setAt ( ts0l, 0, nX3 ); table.setAt ( ts0l, 1, nY3 )
                this._bTrackingStick0 ( true )
                
            elseif ( bTaps4 and this.isUnderComponent ( nX4, nY4, nStick0BackMinX, nStick0BackMinY, nStick0BackMaxX, nStick0BackMaxY ) ) then
                table.setAt ( ts0c, 0, nX4 ); table.setAt ( ts0c, 1, nY4 )
                table.setAt ( ts0l, 0, nX4 ); table.setAt ( ts0l, 1, nY4 )
                this._bTrackingStick0 ( true )
                
            end
        
        end -- tracking end
    end -- component end


    -- right
    if ( hStick1Back ) then
        nStick1BackMinX, nStick1BackMinY = hud.getComponentScreenSpaceBottomLeftCorner ( hStick1Back )
        nStick1BackMaxX, nStick1BackMaxY = hud.getComponentScreenSpaceTopRightCorner   ( hStick1Back )
        
        local sX        = 0.5 * ( nStick1BackMaxX - nStick1BackMinX )
        local sY        = 0.5 * ( nStick1BackMaxY - nStick1BackMinY )
        local cX        = 0.5 * ( nStick1BackMaxX + nStick1BackMinX )
        local cY        = 0.5 * ( nStick1BackMaxY + nStick1BackMinY )
        local dX, dY    = 0
        
        local tcX = table.getAt ( ts1c, 0 )
        local tcY = table.getAt ( ts1c, 1 )
        local tlX = table.getAt ( ts1l, 0 )
        local tlY = table.getAt ( ts1l, 1 )
        
        
        if ( this._bTrackingStick1 ( ) ) then
        
            if ( bTaps0 and math.vectorLength ( nX0 - tlX, nY0 - tlY, 0 ) < 25 ) then
                dX,dY = this._dxdy ( nX0,nY0, cX,cY, tcX,tcY, sX,sY, nA )
                user.sendEventImmediate ( hU, sAI, "onJoypadStickMove", 0, 1, 1.43*dX/sX, 1.43*dY/sY )
                hud.setComponentPosition ( hStick1Thumb, cX + dX, cY + dY )
                table.setAt ( ts1l, 0, nX0 ); table.setAt ( ts1l, 1, nY0 )
                bTaps0 = false
                
            elseif ( bTaps1 and math.vectorLength ( nX1 - tlX, nY1 - tlY, 0 ) < 25 ) then
                dX,dY = this._dxdy ( nX1,nY1, cX,cY, tcX,tcY, sX,sY, nA )
                user.sendEventImmediate ( hU, sAI, "onJoypadStickMove", 0, 1, 1.43*dX/sX, 1.43*dY/sY )
                hud.setComponentPosition ( hStick1Thumb, cX + dX, cY + dY )
                table.setAt ( ts1l, 0, nX1 ); table.setAt ( ts1l, 1, nY1 )
                bTaps1 = false
                
            elseif ( bTaps2 and math.vectorLength ( nX2 - tlX, nY2 - tlY, 0 ) < 25 ) then
                dX,dY = this._dxdy ( nX2,nY2, cX,cY, tcX,tcY, sX,sY, nA )
                user.sendEventImmediate ( hU, sAI, "onJoypadStickMove", 0, 1, 1.43*dX/sX, 1.43*dY/sY )
                hud.setComponentPosition ( hStick1Thumb, cX + dX, cY + dY )
                table.setAt ( ts1l, 0, nX2 ); table.setAt ( ts1l, 1, nY2 )
                bTaps2 = false
                
            elseif ( bTaps3 and math.vectorLength ( nX3 - tlX, nY3 - tlY, 0 ) < 25 ) then
                dX,dY = this._dxdy ( nX3,nY3, cX,cY, tcX,tcY, sX,sY, nA )
                user.sendEventImmediate ( hU, sAI, "onJoypadStickMove", 0, 1, 1.43*dX/sX, 1.43*dY/sY )
                hud.setComponentPosition ( hStick1Thumb, cX + dX, cY + dY )
                table.setAt ( ts1l, 0, nX3 ); table.setAt ( ts1l, 1, nY3 )
                bTaps3 = false

            elseif ( bTaps4 and math.vectorLength ( nX4 - tlX, nY4 - tlY, 0 ) < 25 ) then
                dX,dY = this._dxdy ( nX4,nY4, cX,cY, tcX,tcY, sX,sY, nA )
                user.sendEventImmediate ( hU, sAI, "onJoypadStickMove", 0, 1, 1.43*dX/sX, 1.43*dY/sY )
                hud.setComponentPosition ( hStick1Thumb, cX + dX, cY + dY )
                table.setAt ( ts1l, 0, nX4 ); table.setAt ( ts1l, 1, nY4 )
                bTaps4 = false
                
            else
                -- reset stick
                user.sendEventImmediate ( hU, sAI, "onJoypadStickMove", 0, 1, 0, 0 )
                this._bTrackingStick0 ( false )
                hud.matchComponentScreenSpaceCenter ( hStick1Thumb, hStick1Back )
            end
            
        
        else
        
            if ( bTaps0 and this.isUnderComponent ( nX0, nY0, nStick1BackMinX, nStick1BackMinY, nStick1BackMaxX, nStick1BackMaxY ) ) then
                table.setAt ( ts1c, 0, nX0 ); table.setAt ( ts1c, 1, nY0 )
                table.setAt ( ts1l, 0, nX0 ); table.setAt ( ts1l, 1, nY0 )
                this._bTrackingStick1 ( true )
                
            elseif ( bTaps1 and this.isUnderComponent ( nX1, nY1, nStick1BackMinX, nStick1BackMinY, nStick1BackMaxX, nStick1BackMaxY ) ) then
                table.setAt ( ts1c, 0, nX1 ); table.setAt ( ts1c, 1, nY1 )
                table.setAt ( ts1l, 0, nX1 ); table.setAt ( ts1l, 1, nY1 )
                this._bTrackingStick1 ( true )

            elseif ( bTaps2 and this.isUnderComponent ( nX2, nY2, nStick1BackMinX, nStick1BackMinY, nStick1BackMaxX, nStick1BackMaxY ) ) then
                table.setAt ( ts1c, 0, nX2 ); table.setAt ( ts1c, 1, nY2 )
                table.setAt ( ts1l, 0, nX2 ); table.setAt ( ts1l, 1, nY2 )
                this._bTrackingStick1 ( true )
                
            elseif ( bTaps3 and this.isUnderComponent ( nX3, nY3, nStick1BackMinX, nStick1BackMinY, nStick1BackMaxX, nStick1BackMaxY ) ) then
                table.setAt ( ts1c, 0, nX3 ); table.setAt ( ts1c, 1, nY3 )
                table.setAt ( ts1l, 0, nX3 ); table.setAt ( ts1l, 1, nY3 )
                this._bTrackingStick1 ( true )
                
            elseif ( bTaps4 and this.isUnderComponent ( nX4, nY4, nStick1BackMinX, nStick1BackMinY, nStick1BackMaxX, nStick1BackMaxY ) ) then
                table.setAt ( ts1c, 0, nX4 ); table.setAt ( ts1c, 1, nY4 )
                table.setAt ( ts1l, 0, nX4 ); table.setAt ( ts1l, 1, nY4 )
                this._bTrackingStick1 ( true )
                
            end
        
        end -- tracking end
    end -- component end
    
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
