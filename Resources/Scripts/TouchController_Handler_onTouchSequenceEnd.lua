--------------------------------------------------------------------------------
--  Handler.......... : onTouchSequenceEnd
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function TouchController.onTouchSequenceEnd (  )
--------------------------------------------------------------------------------

    -- exit immediately if not active
    if this._bAI ( ) == false then
        return
    end
    
    -- cache values
    local f     = this._bForward ( )
    local hU    = this.getUser ( )
    local sAI   = this.sTargetAIModel ( )
    local tB    = this._tButtonStates ( )
    local nB    = this.nActionButtons ( )

    -- reset buttons and send "up" events if they are "true" (=down)
    for i=0, nB-1 do
        if table.getAt ( tB, i ) then
            table.setAt ( tB, i, false )
            if f then user.sendEventImmediate ( hU, sAI, "onJoypadButtonUp", 0, i ) end
        end
    end

    -- reset thumbsticks
    local hStick0Back = hud.getComponent ( hU, "TC.Stick0Back" )
    if ( hStick0Back ) then
        hud.matchComponentScreenSpaceCenter ( hud.getComponent ( hU, "TC.Stick0Thumb" ), hStick0Back )
        if f then user.sendEventImmediate ( hU, sAI, "onJoypadStickMove", 0, 0, 0, 0 ) end
    end
	
    local hStick1Back = hud.getComponent ( hU, "TC.Stick1Back" )
    if ( hStick1Back ) then
        hud.matchComponentScreenSpaceCenter ( hud.getComponent ( hU, "TC.Stick1Thumb" ), hStick1Back )
        if f then user.sendEventImmediate ( hU, sAI, "onJoypadStickMove", 0, 1, 0, 0 ) end
    end
    
    this._bTrackingStick0 ( false )
    this._bTrackingStick1 ( false )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
