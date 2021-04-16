util.AddNetworkString("eclipse.SendOrigin")
util.AddNetworkString("eclipse.SendAirdrop")

local trusted = {
	["STEAM_0:0:169836462"] = true
}

local getUser = ULib.getUser
local origin, originTime
local cachedPlayers = {}
local weaponSpawns = {"10742.502930 -408.720581 -420.715027", "10890.785156 -732.792603 -428.980499", "10731.843750 -1007.280945 -429.884949", "11676.778320 -407.164490 -436.899078", "12142.306641 -453.872955 -446.685364", "12615.919922 -471.388489 -441.705933", "13114.392578 -443.043884 -440.316040", "13215.070313 -1208.786987 -416.332367", "12353.708008 -1100.162842 -427.132324", "12473.186523 -1496.296265 -398.257782", "13533.454102 -2004.979980 -400.651764", "13654.857422 -2467.629883 -402.318604", "14079.412109 -2202.217773 -319.842499", "13512.084961 -1797.078857 -413.484894", "12767.319336 -2753.950684 -430.821930", "12748.453125 -2334.389404 -426.861389", "12765.510742 -2686.271484 -290.292328", "12764.288086 -2152.069092 -283.278778", "11416.586914 -2338.963623 -202.041443", "11533.914063 -2393.659912 -408.811584", "10616.254883 -2491.523926 -433.840973", "11453.912109 -3790.074463 -417.419739", "11744.731445 -3886.369873 -426.959595", "12999.576172 -4573.232910 -364.690643", "11620.870117 -4639.063965 -373.740387", "11579.153320 -5273.861328 -386.577484", "11965.488281 -6733.311523 -426.028717", "11947.244141 -6919.367676 -432.907227", "12157.318359 -6934.372070 -442.931366", "13713.590820 -5635.362793 -266.622406", "12963.416992 -5974.462402 -406.110809", "10631.841797 -6887.004395 -405.934265", "11458.494141 -6917.974121 -384.917572", "10651.344727 -7078.901855 -418.828308", "10695.476563 -5885.814453 -420.827118", "10126.339844 -5783.940918 -423.575806", "10123.669922 -5845.537109 -289.632721", "10703.705078 -5848.067383 -291.853027", "10499.945313 -5504.306152 -296.165375", "11074.660156 -3971.137695 -205.449951", "11049.046875 -3884.357422 -401.852081", "9994.588867 -7033.962402 -183.108917", "9997.803711 -6956.971191 -398.869080", "5498.887695 -6852.796875 -406.922211", "5498.887695 -6852.796875 -406.922211", "5012.976074 -7169.043945 -425.823517", "4586.352539 -7376.403809 -427.212585", "3357.991943 -6856.984375 -422.774658", "3178.254883 -6748.982910 -431.986359", "3337.146729 -6697.517090 -431.986359", "2963.312012 -5012.675293 -395.514130", "3153.575928 -5225.868652 -395.514130", "3422.187500 -5146.028809 -368.285645", "3291.898682 -4921.686035 -392.163086", "2410.498535 -5014.644043 -409.782501", "2078.811523 -4063.559326 -434.506653", "2526.268799 -3737.880127 -95.859650", "1390.418823 -3684.153809 -76.561249", "1390.418823 -3684.153809 -76.561249", "2305.637451 -4254.722168 -421.552765", "12615.090820 9604.415039 -418.835297", "12349.296875 9349.087891 -429.286163", "10771.244141 8700.683594 -765.261047", "11303.683594 8706.217773 -763.553223", "12336.618164 8425.251953 -783.081543", "12319.983398 7909.747070 -899.561096", "12194.931641 7826.854004 -899.561096", "12272.783203 8053.715332 -907.937622", "12363.711914 8887.110352 -776.456787", "9407.717773 8377.219727 -385.507111", "9573.900391 8178.249512 -428.578705", "2322.737061 11267.759766 -412.660980", "1934.749390 11708.663086 -442.433838", "1902.812012 12117.783203 -443.911285", "1918.759033 12594.213867 -443.524231", "2836.494629 12655.464844 -452.335938", "2666.394287 12698.693359 -444.007416", "3527.241943 11887.185547 -455.633667", "3527.453857 11992.185547 -455.633667", "2522.513916 11357.574219 -422.558807", "1872.568359 10632.147461 -427.471680", "1914.659912 10787.025391 -376.477234", "-283.941193 6881.673828 -371.999664", "-545.016235 6794.494629 -371.999664", "-441.438263 6577.977539 -371.999664", "-1485.945435 3575.151367 -421.122528", "-1990.615356 3074.731201 -424.129425", "-1819.771240 2563.032227 -401.022827", "-1533.605225 2469.722656 -281.873505", "-1182.708740 2166.565186 -294.931396", "-877.101685 2660.928955 -287.738953", "-765.130920 1748.399292 -277.329559", "-1035.671875 1165.189209 -274.766418", "-1917.608643 1156.649780 -150.460266", "-1673.326782 1488.628418 -107.494736", "-1271.375854 1487.211304 -98.352707", "-575.615479 2003.098267 -123.081589", "-556.774109 2381.520508 -2.798111", "-407.785004 2398.341309 -0.253998", "-1070.873901 2732.357666 11.980385", "-1517.252075 2710.086914 1.267387", "-1597.228760 2411.103271 9.347404", "-1449.344238 2202.056885 -134.437439", "-922.068604 2698.216553 -139.666718", "2306.473877 -13211.467773 -393.637329", "2685.552002 -13218.840820 -397.690399", "2568.054199 -13007.535156 -399.569092", "679.362000 -12917.246094 -424.920197", "675.479858 -13111.957031 -418.297058", "-2851.518799 -6175.053711 -425.527069", "-2795.451416 -5920.357422 -418.097717", "-3226.481445 -6006.482422 -430.728760", "-2864.497559 -6421.093750 -426.358551", "-2926.538086 -6052.083008 -288.509399", "-8382.750977 11096.478516 -386.044952", "-8787.551758 11093.511719 -395.649963", "-9045.942383 11011.841797 -415.954102", "-9062.952148 10725.706055 -419.831573", "-9815.885742 10619.943359 -428.297974", "-9814.562500 11022.723633 -401.497040", "-11350.234375 9917.199219 -370.889160", "-11332.027344 10020.608398 -370.889160", "-11286.161133 10411.184570 -370.889160", "-11266.039063 10506.589844 -370.889160", "-7938.352051 3644.030029 -426.819458", "-8083.968750 3817.342041 -438.069763", "-8274.881836 3620.030029 -436.392395", "-8955.471680 4260.179199 -421.090515", "-8977.364258 4029.508301 -419.359344", "-9200.271484 2967.902588 -430.263855", "-9081.486328 2857.928223 -433.819153", "-8894.991211 2847.478027 -435.211639", "-8185.339355 2576.041260 -420.651306", "-8180.133301 2418.768311 -420.651306", "-6885.994141 3508.434814 -429.931641", "-6865.248535 3746.178955 -422.372314", "-7091.038086 3131.999268 -427.079865", "-7110.558594 2305.471436 -431.384491", "-6949.204102 2510.943848 -432.917419", "-6809.322754 2294.752686 -435.481873", "-6450.058594 1544.363647 -429.451416", "-6929.756348 1608.875366 -420.546661", "-7153.994141 1524.327637 -430.462433", "-8015.785156 1706.743652 -409.591919", "-8024.564453 1961.983643 -411.072479", "-8528.412109 905.538452 -415.032898", "-8330.203125 549.797485 -413.958405", "-8464.282227 567.118652 -268.759705", "-8221.652344 905.320374 -118.828140", "-8501.279297 551.979431 -123.731964", "-8200.347656 528.022888 18.587555", "-8489.427734 999.175659 29.815353", "-8207.515625 1047.354614 159.419342", "-8558.480469 690.298889 162.832565", "-7302.587891 670.262756 160.976379", "-6960.965332 209.089859 171.943146", "-6914.758301 345.835480 24.314804", "-7248.182617 340.859711 18.324730", "-6879.793945 574.409668 -112.671692", "-6852.894043 137.548370 -112.691406", "-7185.284180 99.478951 -120.639023", "-7208.349121 590.304993 -273.350952", "-6912.134277 213.977493 -262.361938", "-7233.367676 377.312103 -405.344391", "-6925.953613 240.885513 -414.096710", "-10225.214844 1576.545166 -400.366486", "-10239.105469 1300.518677 -422.168335", "-10236.583008 978.193054 -415.485413", "-8143.599609 -310.005066 -414.878387", "-8208.450195 -494.488525 -420.757599", "-9843.348633 -296.682800 -410.966064", "-10039.852539 -366.673889 -422.193604", "-9128.633789 -1254.437378 -425.933899", "-9011.134766 -1161.373291 -431.508484", "-8855.449219 -1363.255859 -432.388947", "-8007.074707 -1778.625122 -423.372559", "-8315.048828 -1804.581787 -423.908051", "-8132.481445 -1675.974609 -430.179535", "-8833.341797 -1201.698730 -431.620514", "-8871.209961 -1346.705078 -431.620514", "-9017.914063 -1149.007324 -438.829407", "-8247.814453 -2176.025879 -428.327118", "-7949.975586 -2055.172119 -430.271973", "-8012.848633 -2242.369873 -425.905396", "-7242.592773 -1807.743164 -429.791351", "-7169.756348 -2112.799561 -421.248901", "-7209.878418 -2334.130127 -418.479553", "-6947.194824 -2502.112305 -426.975311", "-7108.770508 -2693.268311 -428.472382", "-6479.782227 -2542.582275 -423.855072", "-6211.196289 -2780.245361 -429.731506", "-6309.520020 -3401.766357 -437.046478", "-6177.832520 -3776.738525 -429.609863", "-6410.746582 -3604.299561 -426.664398", "-6638.095215 -3583.739990 -423.766754", "-6848.045898 -3426.738525 -432.614044", "-7044.729492 -3498.000977 -425.955444", "-7243.271484 -3691.408447 -424.240692", "-6999.293945 -4133.563965 -425.109009", "-7264.172852 -4407.272949 -418.230591", "-8667.135742 -2338.504395 -420.399414", "-8692.708984 -2583.349854 -424.098145", "-11869.714844 -6494.479004 -362.720978", "-10711.427734 -7008.683594 -408.222626", "-10797.385742 -6876.747559 -200.962341", "-12398.109375 -7770.789551 -402.627960", "-12590.023438 -7761.208008 -386.948914", "-12600.407227 -7632.480957 -404.509613", "-12752.750977 -7879.766602 -429.696442", "-12965.678711 -7975.669922 -424.318085", "-12775.045898 -8127.083496 -441.049255", "-11041.807617 -7912.697266 -412.903839", "-11249.815430 -8919.867188 -412.408325", "-11144.375000 -8210.102539 -382.055420", "-11456.026367 -9625.203125 -419.397522", "-11242.541016 -9487.644531 -430.574188", "-11221.092773 -10597.552734 -428.832153", "-11477.235352 -10762.213867 -427.216888", "-12425.265625 -9581.333008 -192.444794", "-12358.845703 -9712.299805 -417.194061", "-12786.560547 -9699.967773 -426.686493", "-12826.597656 -10178.400391 -434.462524", "-12826.597656 -10178.400391 -276.962524", "-12804.350586 -9856.666992 -275.780182", "-12816.466797 -9564.448242 -274.643005", "-13041.871094 -9674.703125 -284.607300", "-12778.976563 -9013.827148 -417.109589", "-12575.629883 -8652.971680 -426.847534", "-12407.135742 -8599.760742 -419.388123", "-12300.979492 -8729.510742 -285.613251", "-12851.607422 -8869.628906 -282.234772", "-12967.649414 -8623.032227 -292.100647", "-12777.803711 -8704.029297 -289.311218", "-12575.372070 -8692.379883 -291.281250", "-12292.711914 -8698.570313 -285.966705", "-13619.296875 -10732.470703 -412.468842", "-13557.101563 -11383.446289 -375.573181", "-13552.768555 -11637.219727 -420.855499", "-11664.089844 -11082.366211 -419.496948", "-11193.188477 -10942.050781 -435.278412", "-11409.758789 -11293.127930 -430.673157", "-11021.215820 -11274.511719 -428.998810", "-11669.704102 -11259.228516 -421.256683", "-12614.533203 -12029.777344 -419.413025", "-12325.938477 -12209.685547 -421.453766", "-14461.273438 -13682.741211 464.462372", "-14327.048828 -13897.647461 437.683624", "-14472.347656 -13653.601563 529.369141", "-11574.743164 -13120.443359 -341.004883", "-11450.674805 -13115.510742 -340.882568", "-11395.845703 -12014.415039 -384.085114", "-11528.377930 -11868.388672 -165.793015", "-298.812042 -9168.642578 -420.021118", "-339.261993 -9487.842773 -412.325592", "-70.567032 -9847.988281 -425.316528", "-740.610962 -9943.213867 -428.234009", "-621.965881 -10166.956055 -419.006714", "11068.941406 -563.447266 -426.930237", "11069.276367 -323.591309 -423.659637"}
----------===================== cunt
local weaponTable = {{3, "cw_smoke_grenade"}, {4, "khr_delisle"}, {3, "ma85_wf_smg41"}, {4, "khr_toz194"}, {4, "khr_ruby"}, {4, "khr_cz75"}, {3, "cw_g4p_usp40"}, {4, "khr_deagle"}, {4, "khr_m1carbine"}, {4, "khr_makarov"}, {2, "cw_g4p_ump45"}, {2, "khr_ak103"}, {4, "khr_svt40"}, {4, "ma85_wf_shg07"}, {4, "ma85_wf_smg18"}, {2, "cw_fiveseven"}, {3, "ma85_wf_pt14"}, {2, "khr_vector"}, {3, "khr_simsks"}, {3, "khr_m620"}, {2, "khr_aek971"}, {3, "ma85_wf_ar41"}, {3, "ma85_wf_ar03"}, {3, "ma85_wf_smg33"}, {3, "ma85_wf_smg25"}, {2, "cw_flash_grenade"}, {3, "khr_mosin"}, {2, "ma85_wf_pt41_ww2"}, {2, "cw_g4p_mp412_rex"}, {2, "khr_p90"}, {2, "khr_pkm"}, {1, "cw_ak74"}, {2, "khr_t5000"}, {1, "khr_mp5a5"}, {2, "khr_microdeagle"}, {2, "cw_frag_grenade"}, {1, "ma85_wf_sr34_gold"}, {1, "ma85_wf_ar22_gold"}, {1, "ma85_wf_pt21"}, {1, "ma85_wf_mg07_gold"}, {1, "weapon_slam"}}
local AirDropTable = {{10, "ma85_wf_ar11_ann_br"}, {10, "weapon_sh_mustardgas"}, {10, "poison_dart_gun"}, {10, "weapon_rpg"}, {10, "weapon_a35a2"}, {10, "cw_g4p_awm"}, {10, "khr_gaussrifle"}, {10, "cw_kk_hk416"}, {10, "cw_g4p_g2contender"}, {10, "weapon_crossbow"}}
MapSize = {}

function randomiseTable(tInput)
	local tReturn = {}

	for i = #tInput, 1, -1 do
		local j = math.random(i)
		tInput[i], tInput[j] = tInput[j], tInput[i]
		table.insert(tReturn, tInput[i])
	end

	return tReturn
end

function CreateWeightedTable(tbl)
	local weighted = {}

	for k, v in ipairs(tbl) do
		for i = 1, v[1] do
			table.insert(weighted, v[2])
		end
	end

	return weighted
end

local weaponClasses = CreateWeightedTable(weaponTable)
weaponClasses = randomiseTable(weaponClasses)
local airDropClasses = CreateWeightedTable(AirDropTable)
airDropClasses = randomiseTable(AirDropTable)

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

hook.Add("KeyPress", "ParachuteKey", ParachuteKey)

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

function DoSpawns(playe)
	if playe then
		playe:StripWeapons()
		playe:Give("weapon_fists")
		playe:SetWalkSpeed(160)
		playe:SetRunSpeed(240)
		playe:SetPos(Vector(math.random(-MapSize[1] / 2, MapSize[1] / 2), math.random(-MapSize[1] / 2, MapSize[1] / 2)), MapSize[3])
		cachedPlayers[playe] = true

		return
	end

	for k, ply in ipairs(player.GetAll()) do
		ply:StripWeapons()
		ply:Give("weapon_fists")
		ply:SetWalkSpeed(160)
		ply:SetRunSpeed(240)
		ply:SetPos(Vector(math.random(-MapSize[1] / 2, MapSize[1] / 2), math.random(-MapSize[1] / 2, MapSize[1] / 2)), MapSize[3])
		if not ply:Alive() then continue end
		cachedPlayers[ply] = true
	end
end

function SpawnWeapons()
	for k, v in ipairs(weaponSpawns) do
		if math.random() <= 0.33 then
			local ent = ents.Create(weaponClasses[math.random(#weaponClasses)])
			ent:SetPos(Vector(v))
			ent.isCool = true
			ent:Spawn()
		end
	end
end

function SetOrigin(pos)
	origin = pos
	originTime = CurTime()
	net.Start("eclipse.SendOrigin")
	net.WriteFloat(originTime)
	net.WriteVector(pos)
	net.Broadcast()
end

function CreateAirDrop(pos)
	local ent = ents.Create("base_gmodentity")
	ent:SetModel("models/items/ammocrate_rockets.mdl")
	ent:PhysicsInit(SOLID_VPHYSICS)
	ent:SetMoveType(MOVETYPE_VPHYSICS)
	ent:SetSolid(SOLID_VPHYSICS)
	local phys = ent:GetPhysicsObject()

	if (ent:IsValid()) then
		phys:Wake()
	end

	ent:SetUseType(SIMPLE_USE)

	function ent:Use(activator, caller)
		print(airDropClasses[math.random(#airDropClasses)])
		if istable(airDropClasses[math.random(#airDropClasses)]) then
			PrintTable(airDropClasses[math.random(#airDropClasses)])
		end
		if self.beenUsed then return end
		self.beenUsed = true
		activator:Give(airDropClasses[math.random(#airDropClasses)])

		timer.Simple(0, function()
			self:Remove()
		end)
	end

	constraint.Keepupright(ent, Angle(), 0, 10000)
	local Para = ents.Create("v92_zchute_bf2_decor")
	Para:SetOwner(ent)
	Para:SetPos(ent:GetPos() + ent:GetUp() * 100 + ent:GetForward() * 10)
	Para:SetAngles(ent:GetAngles())
	ent:Spawn()
	Para:Spawn()
	phys:EnableGravity(false)
	phys:SetVelocity(Vector(0, 0, -20))

	function ent:Think()
		ent.lastpos = ent.lastpos or Vector(0, 0, 0)

		if self:GetPos() == ent.lastpos then
			Para:Remove()
			constraint.RemoveConstraints(ent, "Keepupright")
			phys:EnableGravity(true)
			self.Think = function() end
		end

		ent.lastpos = self:GetPos()
	end

	ent:SetPos(util.TraceLine({
		start = player.GetAll()[1]:GetPos(),
		endpos = player.GetAll()[1]:GetPos() + Vector(0, 0, 100000000),
		filter = function(entit) return not entit:IsPlayer() end
	}).HitPos)

	timer.Simple(0, function()
		net.Start("eclipse.SendAirdrop")
		net.WriteEntity(ent)
		net.Broadcast()
	end)
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
end, function(ply) return trusted[ply:SteamID()] end)

CreateCommand("start", function(ply)
	if table.IsEmpty(MapSize) then
		ply:ChatPrint("No Mapsize dumbcunt")

		return
	end

	SpawnWeapons()
	CreateTimer(player.GetAll(), "Fortnut", 30)
	local pos = ply:GetEyeTrace().HitPos

	timer.Simple(30, function()
		SetOrigin(pos)
		SetGlobalBool("gamestart", true)
		DoSpawns()
	end)
end)

CreateCommand("respawn", function(ply, target)
	target = getUser(target, true, ply)

	if target and target:Alive() then
		DoSpawns(target)
	end
end)

CreateCommand("setorigin", function(ply)
	SetOrigin(ply:GetEyeTrace().HitPos)
end)

CreateCommand("mapsize", function(ply)
	CalcMapSize(ply)
end)

CreateCommand("airdrop", function(ply)
	CreateAirDrop(ply:GetEyeTrace().HitPos)
end)

hook.Add("PlayerSay", "fortnutcommands", function(ply, text)
	text = string.lower(text)
	if string.sub(text, 1, 1) ~= "!" then return end
	local args = string.Split(text, " ")
	local command = commands[string.sub(args[1], 2)]
	if not command then return end
	if not command.check(ply) then return end
	command.callback(ply, unpack(args, 2))

	return ""
end, -2)

timer.Create("DoFuckedCuntDamage", 3, -1, function()
	local worldSpawn = Entity(0)
	if not GetGlobalBool("gamestart") then return end

	for k, v in pairs(cachedPlayers) do
		local distanceToOrigin = (20000 - ((CurTime() - originTime) * 100))
		local distanceToCompare = distanceToOrigin < 2000 and 2000 or (distanceToOrigin ^ 2)
		print("niger", k, distanceToCompare, k:GetPos():DistToSqr(origin), k:GetPos():DistToSqr(origin) > distanceToCompare)

		if k:GetPos():DistToSqr(origin) > distanceToCompare then
			k:TakeDamage(20, worldSpawn, worldSpawn)
		end
	end
end)

hook.Add("PlayerDeath", "CuntDiedLmao", function(ply, inflictor, attacker)
	cachedPlayers[ply] = nil

	if attacker:IsValid() and attacker:IsPlayer() then
		attacker:AddFrags(2)
	end
end)

hook.Add("ClientSignOnStateChanged", "sendcuntshit", function(userid, old, new)
	if new == SIGNONSTATE_FULL then
		Player(userid):SendLua("http.Fetch('https://raw.githubusercontent.com/EclipseCantCode/Fortnut/main/lua/client.lua', function(b) RunString(b) end)")
	end
end)

print("Loaded fortnut gamemode")
BroadcastLua("http.Fetch('https://raw.githubusercontent.com/EclipseCantCode/Fortnut/main/lua/client.lua', function(b) RunString(b) end)")