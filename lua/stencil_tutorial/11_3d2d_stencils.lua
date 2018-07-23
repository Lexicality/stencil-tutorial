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

hook.Add( "PostDrawOpaqueRenderables", "Stencil Tutorial Example", function()

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

	-- Draw a rectangle at a weird angle and location into the stencil buffer
	cam.Start3D2D(Vector( 1014,  -24,  -40 ), Angle( -30, -120, 90 ), 0.5)
	surface.SetDrawColor( color_white )
	-- Note that if you draw something transluncent in here (like a rounded box or text)
	--  you will end up with a solid rectangle the size of what you just drew.
	-- The reason for this due to how blending works, but can be summarised as "because".
	-- For more information, see https://www.khronos.org/opengl/wiki/Blending
	surface.DrawRect( 0, 0, 200, 200 )
	cam.End3D2D()

	-- Render the result
	render.SetStencilCompareFunction( STENCIL_EQUAL )
	render.ClearBuffersObeyStencil( 0, 148, 133, 255, false );

	-- Let everything render normally again
	render.SetStencilEnable( false )

end )
