local net_Receive = net.Receive
local net_ReadFloat = net.ReadFloat
local net_ReadVector = net.ReadVector
local hook_Add = hook.Add
local GetGlobalBool = GetGlobalBool
local CurTime = CurTime
local render_DrawWireframeSphere = CLIENT and render.DrawWireframeSphere
local Color = Color
local chat_AddText = CLIENT and chat.AddText
local net_ReadEntity = net.ReadEntity
origin = origin or nil
originTime = originTime or nil
local airdrops = {}

net_Receive("eclipse.SendAirdrop", function()
	local thing = net.ReadEntity()
	print(thing)
	table.insert(airdrops, thing)
end)

net_Receive("eclipse.SendOrigin", function()
	originTime, origin = net_ReadFloat(), net_ReadVector()
end)

hook_Add("PostDrawTranslucentRenderables", "DrawFuckedCunts", function()
	if GetGlobalBool("gamestart") and origin and originTime then
		local distanceToOrigin = (20000 - ((CurTime() - originTime) * 100))
		local distanceToCompare = distanceToOrigin < 2000 and 2000 or distanceToOrigin
		render.SetColorMaterial()
		render_DrawSphere(origin, distanceToCompare, 50, 50, Color(0, 58, 14))
	end
end)

local color_green = Color(0, 255, 0)

hook_Add("PreDrawHalos", "DrawIdiots", function()
	for k, v in ipairs(airdrops) do
		if not v:IsValid() then
			table.remove(airdrops, k)
		end
	end

	halo.Add(airdrops, color_green, 5, 5, 1, true, true)
end)

chat_AddText("Loaded Clientside fortnut")