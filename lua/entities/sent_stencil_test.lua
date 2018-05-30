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
AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName = "Stencil Test"
ENT.Author    = "Lexi"
ENT.Spawnable = true
ENT.Category  = "Dev Stuff"

if ( SERVER ) then

	function ENT:Initialize()

		self:SetModel( "models/hunter/plates/plate1x1.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )

	end

else

	local cvar = CreateConVar( "stencil_tutorial_draw_ents", 0, FCVAR_NONE, "If the stencil test entities should draw normally" )
	cvars.AddChangeCallback( cvar:GetName(), function(_, old, new)

		for _, ent in pairs( ents.FindByClass( "sent_stencil_test" ) ) do

			ent:SetNoDraw( not tobool( new ) )

		end

	end, "sent_stencil_test" )

	function ENT:Initialize()

		self:SetNoDraw( not cvar:GetBool() )

	end

end
