--------------------------------------------------------------------------------
--  Handler.......... : onMouseMove
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function TouchController.onMouseMove ( nPointX, nPointY, nDeltaX, nDeltaY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------
	
    -- exit straight away if mouse emulation is not wanted
	if not this.bEnableMouseForDebugging ( ) then
        return
    end
    
    local hU = this.getUser ( )
    
    if this._bMouseDown ( ) then
        user.sendEventImmediate ( hU, "TouchController", "onTouchSequenceChange", 1, nPointX, nPointY, -1, nil, nil, -1, nil, nil )
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
