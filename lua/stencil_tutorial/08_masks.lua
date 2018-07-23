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
	--[[
        To understand this tutorial you need to already understand the basics
         of binary and bitwise operations.

        It would also help to understand hexadecimal notation, since Lua
         doesn't have a bitmask input, but I will include binary notation in
         comments to help.
	--]]

	-- Reset everything to known good
	-- render.SetStencilWriteMask( 0xFF )
	-- render.SetStencilTestMask( 0xFF )
	render.SetStencilReferenceValue( 0 )
	-- render.SetStencilCompareFunction( STENCIL_ALWAYS )
	render.SetStencilPassOperation( STENCIL_KEEP )
	-- render.SetStencilFailOperation( STENCIL_KEEP )
	render.SetStencilZFailOperation( STENCIL_KEEP )
	render.ClearStencil()

	-- Enable stencils
	render.SetStencilEnable( true )
	-- Force everything to fail
	render.SetStencilCompareFunction( STENCIL_NEVER )
	-- Save all the things we don't draw
	render.SetStencilFailOperation( STENCIL_REPLACE )

	-- Set the reference value to 00011100
	render.SetStencilReferenceValue( 0x1C )
	-- Set the write mask to 01010101
	-- Any writes to the stencil buffer will be bitwise ANDed with this mask.
	-- With our current reference value, the result will be 00010100.
	render.SetStencilWriteMask( 0x55 )

	-- Fail to draw our entities.
	for _, ent in pairs( ents.FindByClass( "sent_stencil_test" ) ) do
		ent:DrawModel()
	end

	-- Set the test mask to 11110011.
	-- Any time a pixel is read out of the stencil buffer it will be bitwise ANDed with this mask.
	render.SetStencilTestMask( 0xF3 )
	-- Set the reference value to 00011100 & 01010101 & 11110011
	render.SetStencilReferenceValue( 0x10 )
	-- Pass if the masked buffer value matches the unmasked reference value
	render.SetStencilCompareFunction( STENCIL_EQUAL )

	-- Draw our entities
	render.ClearBuffersObeyStencil( 0, 148, 133, 255, false );

	-- Let everything render normally again
	render.SetStencilEnable( false )
end )

