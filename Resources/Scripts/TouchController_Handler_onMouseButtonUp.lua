--------------------------------------------------------------------------------
--  Handler.......... : onMouseButtonUp
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function TouchController.onMouseButtonUp ( nButton, nPointX, nPointY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------
	
    -- exit straight away if mouse emulation is not wanted
	if not this.bEnableMouseForDebugging ( ) then
        return
    end
    
    local hU = this.getUser ( )
    
    this._bMouseDown ( false )
    user.sendEvent ( hU, "TouchController", "onTouchSequenceEnd" )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
