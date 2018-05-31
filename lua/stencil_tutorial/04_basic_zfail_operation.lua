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
	render.SetStencilFailOperation( STENCIL_KEEP )
	-- render.SetStencilZFailOperation( STENCIL_KEEP )
	render.ClearStencil()

	-- Enable stencils
	render.SetStencilEnable( true )
	-- Set the reference value to 1. This is what the compare function tests against
	render.SetStencilReferenceValue( 1 )
	-- Always draw everything
	render.SetStencilCompareFunction( STENCIL_ALWAYS )
	-- If something would draw to the screen but is behind something, set the pixels it draws to 1
	render.SetStencilZFailOperation( STENCIL_REPLACE )

	-- Draw our entities. They will draw as normal
	for _, ent in pairs( ents.FindByClass( "sent_stencil_test" ) ) do
		ent:DrawModel()
	end

	-- Now, only draw things that have their pixels set to 1. This is the hidden parts of the stencil tests.
	render.SetStencilCompareFunction( STENCIL_EQUAL )
	-- Flush the screen. This will draw teal over all hidden sections of the stencil tests
	render.ClearBuffersObeyStencil(0, 148, 133, 255, false);

	-- Let everything render normally again
	render.SetStencilEnable( false )
end )

