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

	-- Only write to the upper 4 bits of the stencil buffer
	render.SetStencilWriteMask( 0xF0 )
	-- Wipe the stencil buffer to be 0001111. This is not affected by the write mask.
	render.ClearStencilBufferRectangle( 0, 0, ScrW(), ScrH(), 0x0F )

	-- Always fail
	render.SetStencilCompareFunction( STENCIL_NEVER )
	-- Don't read any bits from the stencil buffer
	render.SetStencilTestMask( 0x00 )
	-- When an operation fails, read the current value from the stencil buffer, add
	--  one to it and then write it back to the buffer
	-- This is not affected by the test mask, but it is affected by the write mask
	-- This means we will read 00001111, then write 00010000.
	-- However, due to the write mask, this won't affect the last four bits already
	--  in the buffer, resulting in 00011111.
	render.SetStencilFailOperation( STENCIL_INCR )

	-- Add something interesting to the stencil buffer
	for _, ent in pairs( ents.FindByClass( "sent_stencil_test" ) ) do
		ent:DrawModel()
	end


	-- Go back to reading the full value from the stencil buffer
	render.SetStencilTestMask( 0xFF )
	-- Set the reference value to 00011111
	render.SetStencilReferenceValue( 0x1F )
	-- Render the result
	render.SetStencilCompareFunction( STENCIL_EQUAL )
	render.ClearBuffersObeyStencil( 0, 148, 133, 255, false );

	-- Let everything render normally again
	render.SetStencilEnable( false )
end )

