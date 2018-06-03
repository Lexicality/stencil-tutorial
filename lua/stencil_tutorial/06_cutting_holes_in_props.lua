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
	-- Force everything to fail
	render.SetStencilCompareFunction( STENCIL_NEVER )
	-- Save all the things we don't draw
	render.SetStencilFailOperation( STENCIL_REPLACE )

	-- Fail to draw our entities.
	for _, ent in pairs( ents.FindByClass( "sent_stencil_test" ) ) do
		ent:DrawModel()
	end

	-- Render all pixels that don't have their stencil value as 1
	render.SetStencilCompareFunction( STENCIL_NOTEQUAL )
	-- Don't modify the stencil buffer when things fail
	render.SetStencilFailOperation( STENCIL_KEEP )

	-- Draw our big entities. They will have holes in them wherever the smaller entities were
	for _, ent in pairs( ents.FindByClass( "sent_stencil_test_big" ) ) do
		ent:DrawModel()
	end

	-- Let everything render normally again
	render.SetStencilEnable( false )
end )

