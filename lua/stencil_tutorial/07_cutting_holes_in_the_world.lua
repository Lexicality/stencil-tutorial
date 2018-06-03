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

-- Set up a global flag to avoid double rendering
local drawing = false;
-- Create a rendertarget the size of the screen to store the back of our window in
local rt = GetRenderTarget("Stencil Tutorial", ScrW(), ScrH())
hook.Add( "PostDrawOpaqueRenderables", "Stencil Tutorial Example", function()
	-- We're going to recursively render everything, so don't run the stencils twice
	if ( drawing ) then
		return
	end

	-- We need to store a copy of the world before we modify it with stencils
	-- To do this, we first start rendering to our texture instead of the screen
	render.PushRenderTarget( rt )
	-- Set the flag
	drawing = true;
	-- Render the current world, but a bit less of it
	render.RenderView({
		-- This needs to be the distance from EyePos to the wall you're cutting a hole in + a bit more.
		-- In this case I've cheated and picked a number that works with my static camera. You will need to be more clever.
		znear = 150;
	});
	-- Put everything back how it was
	drawing = false;
	render.PopRenderTarget()


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
	-- Force everything to fail
	render.SetStencilCompareFunction( STENCIL_NEVER )
	-- Save all the things we don't draw
	render.SetStencilFailOperation( STENCIL_REPLACE )

	-- Fail to draw our entities.
	for _, ent in pairs( ents.FindByClass( "sent_stencil_test" ) ) do
		ent:DrawModel()
	end

	-- Only render where our entities are
	render.SetStencilCompareFunction( STENCIL_EQUAL )
	-- Don't modify the stencil buffer when things fail
	render.SetStencilFailOperation( STENCIL_KEEP )

	-- Draw the copy of the world we just drew
	render.DrawTextureToScreen( rt )

	-- Let everything render normally again
	render.SetStencilEnable( false )
end )

