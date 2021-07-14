local net_ReadEntity = net.ReadEntity
local table_insert = table.insert
local render_SetColorMaterial = CLIENT and render.SetColorMaterial
local render_DrawSphere = render.DrawSphere
local ipairs = ipairs
local table_remove = table.remove
local halo_Add = CLIENT and halo.Add
local net_Receive = net.Receive
local net_ReadFloat = net.ReadFloat
local net_ReadVector = net.ReadVector
local hook_Add = hook.Add
local GetGlobalBool = GetGlobalBool
local CurTime = CurTime
local Color = Color
-- local chat_AddText = CLIENT and chat.AddText
origin = origin or nil
originTime = originTime or nil
local airdrops = {}

net_Receive("eclipse.SendAirdrop", function()
    local thing = net_ReadEntity()
    table_insert(airdrops, thing)
end)

net_Receive("eclipse.SendOrigin", function()
    originTime, origin = net_ReadFloat(), net_ReadVector()
end)

local color_gre = Color(0, 58, 14, 250)

hook_Add("PostDrawTranslucentRenderables", "DrawFuckedCunts", function()
    if GetGlobalBool("gamestart") and origin and originTime then
        local distanceToOrigin = (25000 - ((CurTime() - originTime) * 50))
        local distanceToCompare = distanceToOrigin < 2000 and 2000 or distanceToOrigin
        render_SetColorMaterial()
        render_DrawSphere(origin, distanceToCompare, 50, 50, color_gre)
        render_DrawSphere(origin, -distanceToCompare, 50, 50, color_gre)
    end
end)

local color_green = Color(0, 255, 0)

hook_Add("PreDrawHalos", "DrawIdiots", function()
    for k, v in ipairs(airdrops) do
        if not v:IsValid() then
            table_remove(airdrops, k)
        end
    end

    halo_Add(airdrops, color_green, 5, 5, 1, false, true)
end)

-- chat_AddText("Loaded Clientside fortnut")