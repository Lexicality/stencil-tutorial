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
	-- Set the reference value to 1. This is what the compare function tests against
	render.SetStencilReferenceValue( 1 )
	-- Only draw things if their pixels are currently 1. Currently this is nothing.
	render.SetStencilCompareFunction( STENCIL_EQUAL )
	-- If something fails to draw to the screen, set the pixels it would have drawn to 1
	-- This includes if it's behind something.
	render.SetStencilFailOperation( STENCIL_REPLACE )

	-- Draw our entities. They will not draw, because everything is 0
	for _, ent in pairs( ents.FindByClass( "sent_stencil_test" ) ) do
		ent:DrawModel()
	end

	-- If we were to re-draw our entities, we'd see them, but otherwise they're invisible.
	-- If we flush the screen, we can show the "holes" they've left in the stencil buffer
	render.ClearBuffersObeyStencil(0, 148, 133, 255, false);

	-- Let everything render normally again
	render.SetStencilEnable( false )
end )

