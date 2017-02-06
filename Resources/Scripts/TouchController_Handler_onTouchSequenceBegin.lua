--------------------------------------------------------------------------------
--  Handler.......... : onTouchSequenceBegin
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function TouchController.onTouchSequenceBegin (  )
--------------------------------------------------------------------------------
	
    -- exit immediately if not active
    if this._bAI ( ) == false then
        return
    end
    
    -- reset all tables
    local tB = this._tButtonStates ( )
    local nB = this.nActionButtons ( )
    for i=0, nB-1 do table.setAt ( tB, i, false ) end
    
    table.setRangeAt ( this._tStick0C ( ), 0, 0,0 )
    table.setRangeAt ( this._tStick0L ( ), 0, 0,0 )
    table.setRangeAt ( this._tStick1C ( ), 0, 0,0 )
    table.setRangeAt ( this._tStick1L ( ), 0, 0,0 )
    
    this._bTrackingStick0 ( false )
    this._bTrackingStick1 ( false )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
