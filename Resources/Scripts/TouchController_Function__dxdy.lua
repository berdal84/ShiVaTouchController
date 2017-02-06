--------------------------------------------------------------------------------
--  Function......... : _dxdy
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function TouchController._dxdy ( nX, nY, cX, cY, tcX, tcY, sX, sY, nA )
--------------------------------------------------------------------------------
	
    local dX,dY = 0
    
    if ( this.nJoypadType ( ) == 0 ) then
        dX        = nX - tcX
        dY        = ( nY - tcY ) / nA
    elseif ( this.nJoypadType ( ) == 1 ) then
        dX        = nX - cX
        dY        = ( nY - cY ) / nA
    end
    
    
    local dL      = math.sqrt ( dX * dX + dY * dY )
    local dLimX   = sX * 0.7
    local dLimY   = sY * 0.7
                      
    if ( dL > dLimX or dL > dLimY ) then
        dX = dX / dL * dLimX
        dY = dY / dL * dLimY
    else
        dY = dY * nA
    end
    
    
    return dX,dY
	
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
