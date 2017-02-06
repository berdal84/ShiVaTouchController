--------------------------------------------------------------------------------
--  Handler.......... : onMouseButtonDown
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function TouchController.onMouseButtonDown ( nButton, nPointX, nPointY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------
	
    -- exit straight away if mouse emulation is not wanted
	if not this.bEnableMouseForDebugging ( ) then
        return
    end
    
    local hU = this.getUser ( )
    
    this._bMouseDown ( true )
    user.sendEventImmediate ( hU, "TouchController", "onTouchSequenceBegin" )
    user.sendEventImmediate ( hU, "TouchController", "onTouchSequenceChange", 1, nPointX, nPointY, -1, nil, nil, -1, nil, nil )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
