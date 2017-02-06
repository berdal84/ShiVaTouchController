--------------------------------------------------------------------------------
--  Handler.......... : onKeyboardKeyDown
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function YourStringHere.onKeyboardKeyDown ( kKeyCode )
--------------------------------------------------------------------------------
	
	if kKeyCode == input.kKey1 then
        log.message ( "Enabling TC" )
        user.sendEvent ( this.getUser ( ), "TouchController", "onEnable", true )
    elseif kKeyCode == input.kKey0 then
        log.message ( "Disabling TC" )
        user.sendEvent ( this.getUser ( ), "TouchController", "onEnable", false )
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
