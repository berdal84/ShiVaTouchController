--------------------------------------------------------------------------------
--  Handler.......... : onJoypadStickMove
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function YourStringHere.onJoypadStickMove ( nJoypad, nStick, nAxisX, nAxisY )
--------------------------------------------------------------------------------

    local sum = nAxisX + nAxisY
    
    if nStick == 0 and sum ~= this._nLastJoy1 ( ) then
        -- your action for left stick
        log.message ( "DEBUG: Joy #1 Stick #"..nStick.." X:"..math.trunc ( nAxisX, 2 ).." Y:"..math.trunc ( nAxisY, 2 ) )
    elseif nStick == 1 and sum ~= this._nLastJoy2 ( ) then
        -- your action for right stick
        log.message ( "DEBUG: Joy #2 Stick #"..nStick.." X:"..math.trunc ( nAxisX, 2 ).." Y:"..math.trunc ( nAxisY, 2 ) )
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
