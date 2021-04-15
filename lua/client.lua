local net_Receive = net.Receive
local net_ReadFloat = net.ReadFloat
local net_ReadVector = net.ReadVector
local hook_Add = hook.Add
local GetGlobalBool = GetGlobalBool
local CurTime = CurTime
local render_DrawWireframeSphere = CLIENT and render.DrawWireframeSphere
local Color = Color
local chat_AddText = CLIENT and chat.AddText

origin = origin or nil
originTime = originTime or nil

net_Receive("eclipse.SendOrigin", function()
	originTime, origin = net_ReadFloat(), net_ReadVector()
end)

hook_Add("PostDrawTranslucentRenderables", "DrawFuckedCunts", function()
	if GetGlobalBool("gamestart") and origin and originTime then
        local distanceToOrigin = (20000 - ((CurTime() - originTime) * 100))
		local distanceToCompare = distanceToOrigin < 2000 and 2000 or distanceToOrigin
		render_DrawWireframeSphere(origin, distanceToCompare, 50, 50, Color(0, 217, 255), true)
	end
end)

chat_AddText("Loaded Clientside fortnut")