--------------------------------------------------------------------------------
--  Handler.......... : onEnable
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function TouchController.onEnable ( bEnable )
--------------------------------------------------------------------------------

    local hU = this.getUser ( )
    
    -- switch OFF if parameter is false
    if not bEnable then
        this._bForward ( false )
        this._bAI ( false )
        
        hud.destroyTemplateInstance ( hU, "TC" )
        
        return
    end
    
    -- ELSE: otherwise enable multitouch gamepad emulation aka TouchController!
    
    
    -- enable multitouch
    if not input.enableMultiTouch ( hU, true ) then
        log.warning ( "TouchController: Device does not appear to support multitouch!" )
    else
        log.message ( "TouchController: Enabling multitouch support" )
    end
        
    -- instantiate the HUD template if available
    if not hud.newTemplateInstance ( hU, "TouchController", "TC" ) then
        log.warning ( "TouchController: HUD could not be instantiated, shutting down." )
        return
    end
        
    
    -- otherwise init private vars
    local tB = this._tButtonStates ( )
    local nB = this.nActionButtons ( )
    table.reserve ( tB, nB ) -- reserve 10 buttons by default, or as many as you want
    
    local t0 = this._tStick0C ( )
    table.reserve ( t0, 2 ); table.add ( t0, 0 ); table.add ( t0, 0 )
    t0 = this._tStick0L ( )
    table.reserve ( t0, 2 ); table.add ( t0, 0 ); table.add ( t0, 0 )

    t0 = this._tStick1C ( )
    table.reserve ( t0, 2 ); table.add ( t0, 0 ); table.add ( t0, 0 )
    t0 = this._tStick1L ( )
    table.reserve ( t0, 2 ); table.add ( t0, 0 ); table.add ( t0, 0 )

    
    -- check for target AI
    local sAI = this.sTargetAIModel ( )
    if not user.hasAIModel ( hU, sAI ) then
        log.warning ( "TouchController: User does not have an AI named '"..sAI.."', so event forwarding will not work!" )
    else
        this._bForward ( true )
    end

    
    -- generate all necessary actions
    for i=0, nB-1 do
        
        -- declate all button states false = up
        table.add ( tB, false )
        
        -- generic button flashing
        if not this._bHasActions ( ) then
            local a = hud.newAction ( hU, "TC_onFlashButton"..i )
            
            hud.beginActionCommand ( a, hud.kCommandTypeSetBackgroundColor )
            hud.pushActionCommandArgument ( a, hud.getComponent ( hU, "TC.Button"..i ) )
            hud.pushActionCommandArgument ( a, 255 )
            hud.pushActionCommandArgument ( a, 255 )
            hud.pushActionCommandArgument ( a, 255 )
            hud.pushActionCommandArgument ( a, 255 )
            hud.endActionCommand ( a )
            
            hud.beginActionCommand ( a, hud.kCommandTypeInterpolateBackgroundColor )
            hud.pushActionCommandArgument ( a, hud.getComponent ( hU, "TC.Button"..i ) )
            hud.pushActionCommandArgument ( a, 127 )
            hud.pushActionCommandArgument ( a, 127 )
            hud.pushActionCommandArgument ( a, 127 )
            hud.pushActionCommandArgument ( a, 255 )
            hud.pushActionCommandArgument ( a, hud.kInterpolatorTypeLinear )
            hud.pushActionCommandArgument ( a, 500 )
            hud.endActionCommand ( a )
        end
        
    end
    
    this._bHasActions ( true )
    
    
    -- declare successful init
    this._bAI ( true )
    log.message ( "TouchController: Init successful" )
    
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
