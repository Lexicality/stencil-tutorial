--[[
    Copyright 2018 Lex Robinson

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
--]]

local AAAA = string.rep( string.rep( "A", 83 ) .. "\n", 37 )
local poly = {
	{ x = 200, y = 50 },
	{ x = 600, y = 200 },
	{ x = 790, y = 400 },
	{ x = 500, y = 600 },
	{ x = 400, y = 600 },
	{ x = 300, y = 500 },
	{ x = 100, y = 300 },
	{ x =  55, y = 100 },
}

hook.Add( "HUDPaint", "Stencil Tutorial Example", function()

	-- Reset everything to known good
	render.SetStencilWriteMask( 0xFF )
	render.SetStencilTestMask( 0xFF )
	render.SetStencilReferenceValue( 0 )
	-- render.SetStencilCompareFunction( STENCIL_ALWAYS )
	render.SetStencilPassOperation( STENCIL_KEEP )
	-- render.SetStencilFailOperation( STENCIL_KEEP )
	render.SetStencilZFailOperation( STENCIL_KEEP )
	render.ClearStencil()

	-- Enable stencils
	render.SetStencilEnable( true )
	-- Set everything up everything draws to the stencil buffer instead of the screen
	render.SetStencilReferenceValue( 1 )
	render.SetStencilCompareFunction( STENCIL_NEVER )
	render.SetStencilFailOperation( STENCIL_REPLACE )

	-- Draw a weird shape to the stencil buffer
	draw.NoTexture()
	surface.SetDrawColor( color_white )
	surface.DrawPoly( poly )

	-- Only draw things that are in the stencil buffer
	render.SetStencilCompareFunction( STENCIL_EQUAL )
	render.SetStencilFailOperation( STENCIL_KEEP )

	-- Draw our clipped text
	draw.DrawText( AAAA, "TargetID", 50, 50 )

	-- Let everything render normally again
	render.SetStencilEnable( false )

end )
