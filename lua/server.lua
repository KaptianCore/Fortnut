util.AddNetworkString("eclipse.SendOrigin")
util.AddNetworkString("eclipse.SendAirdrop")

local trusted = {
	["STEAM_0:0:169836462"] = true, -- Eclipse
	["STEAM_0:0:91079522"] = true -- Russ
}

local getUser = ULib.getUser
local origin, originTime
local cachedPlayers = {}
local weaponSpawns = {"12750.272461 14478.343750 -41.126221",
"13236.167969 14853.528320 -51.551506",
"13355.809570 14672.061523 -43.633194",
"12284.341797 14050.380859 249.773224",
"12223.455078 14313.544922 229.357773",
"11267.564453 14079.007813 245.363449",
"11228.796875 14262.788086 234.319717",
"11228.992188 14648.063477 230.701370",
"11975.092773 14798.811523 230.862015",
"11975.092773 14798.811523 230.862015",
"11371.091797 13263.825195 272.936707",
"11100.386719 12947.702148 247.117691",
"11454.214844 13514.484375 247.568359",
"12078.850586 13511.157227 250.726257",
"12302.635742 13233.239258 236.960312",
"12442.955078 13440.216797 251.532776",
"11780.509766 14383.833008 484.617676",
"11790.907227 13631.201172 492.706482",
"12168.028320 13006.987305 481.737122",
"11807.808594 12831.096680 488.242889",
"11462.711914 12947.307617 492.614746",
"12163.491211 13445.610352 470.050995",
"12207.940430 13724.590820 477.861389",
"11428.234375 13748.835938 484.527893",
"11336.951172 13449.458984 477.002655",
"11939.511719 14386.090820 8.801193",
"11963.953125 15006.384766 -8.018425",
"11368.593750 14698.298828 -0.947021",
"10935.049805 14629.598633 -7.775970",
"10786.015625 14685.005859 -9.034599",
"11261.099609 15081.608398 -7.587875",
"11567.532227 15400.049805 -8.608101",
"11199.666992 15432.790039 -17.912186",
"10550.693359 13927.157227 -62.621559",
"10713.760742 14169.024414 -78.890030",
"13221.800781 11811.981445 195.747604",
"13167.034180 11264.399414 174.526459",
"13749.931641 11787.771484 179.877563",
"13407.202148 11418.365234 391.105499",
"13837.449219 11249.387695 390.090240",
"14010.583984 10526.508789 190.744858",
"13539.035156 10467.540039 167.712250",
"12980.918945 10522.021484 181.298203",
"12260.894531 10075.664063 440.018738",
"11259.469727 10083.388672 469.475342",
"10262.121094 12218.668945 175.437012",
"9214.492188 12082.405273 157.431732",
"9568.380859 12432.658203 156.068207",
"10485.748047 11519.934570 169.387131",
"10760.215820 11301.717773 158.092194",
"10295.674805 11774.120117 153.530304",
"9103.138672 11043.191406 149.932861",
"9013.704102 11491.295898 145.122299",
"9214.823242 11218.050781 184.383392",
"9880.639648 11550.544922 208.708969",
"10062.944336 11235.742188 240.452652",
"9441.453125 10228.005859 197.915802",
"8968.343750 10070.241211 191.036743",
"8433.458008 10150.941406 198.303818",
"7127.599121 10027.657227 443.515106",
"7519.904785 11737.702148 258.777344",
"7172.936523 12782.220703 448.961639",
"7214.505859 13808.210938 463.304535",
"8143.741211 14654.047852 176.375153",
"8911.602539 14660.119141 174.069489",
"8650.613281 14336.268555 191.664139",
"-159.132523 13395.445313 855.280151",
"-946.400452 13253.910156 868.901367",
"-1199.209473 12991.428711 859.441284",
"-1141.912842 12276.903320 905.289185",
"-1498.072021 12395.235352 931.997864",
"-6708.627441 10918.129883 511.039764",
"-7658.226074 10325.224609 441.943451",
"-8182.161133 9761.242188 388.678772",
"-7948.119629 9579.414063 395.073669",
"-8474.802734 9760.316406 552.247925",
"-8504.315430 10189.980469 533.640686",
"-8879.179688 10107.327148 535.584595",
"-8800.146484 11374.968750 397.105194",
"-8579.142578 11810.683594 393.025909",
"-9245.005859 12012.783203 385.668427",
"-9060.479492 11328.493164 365.351013",
"-9062.467773 11186.050781 364.350708",
"-8577.725586 11134.090820 365.179291",
"-8848.586914 13721.641602 423.715027",
"-8531.640625 13782.174805 418.959167",
"-9321.434570 13859.692383 409.693542",
"-10131.169922 14153.265625 416.076508",
"-10720.924805 14416.000977 428.099274",
"-9954.658203 14545.064453 437.610718",
"-11270.029297 13781.424805 413.443573",
"-11368.416016 13572.715820 412.358856",
"-10809.173828 11945.519531 408.571289",
"-10450.240234 11823.311523 392.297272",
"-10317.677734 11976.149414 383.266449",
"-11467.269531 12203.851563 420.043304",
"-11668.607422 12026.598633 423.224945",
"-12354.905273 13672.408203 439.819153",
"-12351.431641 13924.791992 431.788513",
"-12546.547852 14169.202148 431.455688",
"-12855.345703 14237.260742 442.123505",
"-12078.942383 14020.627930 427.462128",
"-13218.019531 13662.324219 446.623138",
"-13041.623047 10497.775391 243.629959",
"-13368.340820 10378.954102 221.167877",
"-13046.617188 10112.893555 244.513229",
"-12173.082031 10279.091797 281.283203",
"-11774.539063 10532.534180 291.820038",
"-11345.718750 10819.120117 309.766235",
"-11178.536133 10185.270508 285.818237",
"-11058.282227 9309.221680 215.952484",
"-11052.127930 9255.875977 457.011688",
"-13686.779297 6701.660645 169.095398",
"-13709.313477 6557.601074 169.177383",
"-13379.590820 7679.128418 165.925217",
"-13722.323242 7990.720215 154.306885",
"-13070.647461 7817.783203 157.528778",
"-10975.680664 6743.274902 241.492218",
"-11342.093750 7097.154785 244.618591",
"-10764.037109 7086.002930 286.665924",
"-9793.970703 6700.924316 344.938629",
"-9808.662109 6586.166504 355.627869",
"-8493.845703 7891.558594 444.650421",
"-8327.384766 7539.074707 430.139313",
"-8712.998047 7733.653809 428.710144",
"-8718.487305 7430.780762 451.861328",
"-8992.420898 8048.236816 406.194397",
"-9718.202148 6765.867188 350.710297",
"-9805.649414 6551.570313 356.534088",
"-8804.707031 6453.106934 346.177765",
"-8665.118164 6195.568848 319.508698",
"-8615.422852 5854.218262 317.268005",
"-8786.972656 5902.951660 314.928711",
"-9594.773438 5178.218262 309.143616",
"-11460.796875 2242.187500 683.705811",
"-11488.565430 2042.512085 673.296509",
"-11695.050781 1956.917358 661.544800",
"-11284.955078 2085.592285 669.235352",
"-8567.094727 -772.681885 771.030945",
"-8102.614746 -3012.530273 748.805542",
"-5717.074219 -167.439529 2752.921875",
"-5195.056152 2669.360840 2597.810791",
"-10837.750977 -9701.731445 467.334839",
"-11869.205078 -10010.421875 359.442871",
"-12302.370117 -10056.708008 370.198029",
"-12458.174805 -9794.343750 348.876984",
"-12215.102539 -10332.911133 342.629150",
"-12002.349609 -9993.446289 190.262177",
"-12964.545898 -11272.162109 368.714630",
"-12655.385742 -11598.456055 370.439392",
"-12327.735352 -11369.198242 372.487976",
"-12431.668945 -11860.254883 181.549805",
"-12945.026367 -11343.701172 170.438232",
"-13012.039063 -11948.958984 173.988129",
"-11368.701172 -11755.773438 179.358398",
"-10715.922852 -11747.063477 189.530411",
"-9083.053711 -10774.956055 184.267212",
"-8750.103516 -10319.410156 200.199432",
"-9090.350586 -10062.036133 196.679337",
"-8346.812500 -10109.956055 212.113449",
"-7883.477051 -10789.850586 198.036331",
"-8084.916504 -10127.574219 248.265366",
"-7773.463867 -10050.710938 243.636810",
"-7064.967773 -10798.239258 229.166718",
"-7185.071777 -10777.125000 233.549255",
"-7530.985352 -11285.506836 141.080429",
"-7190.754883 -10900.454102 -10.443214",
"-7648.094238 -10713.086914 -18.597374",
"-7027.219727 -10590.624023 -21.250420",
"-7029.692871 -10959.647461 -15.204201",
"-7832.305664 -11503.668945 232.502945",
"-8019.994629 -11482.191406 267.629272",
"-9025.297852 -13462.411133 178.925964",
"-8535.958984 -13274.072266 161.714752",
"-10207.199219 -13382.833008 200.007568",
"-12259.761719 -13375.999023 177.491394",
"-13377.442383 -13461.559570 -76.310883",
"-12705.126953 -14103.027344 -51.367271",
"-11672.398438 -14085.983398 172.463409",
"-12109.631836 -13838.465820 192.918198",
"-11882.529297 -14126.911133 170.095490",
"-11906.659180 -14493.007813 174.136688",
"-13002.754883 -14427.455078 172.008423",
"-13393.410156 -14069.846680 166.350037",
"-13196.162109 -14396.053711 161.792328",
"-12948.567383 -13996.093750 180.923172",
"-13469.359375 -14718.065430 226.528275",
"-13650.576172 -13302.524414 241.833054",
"-12055.538086 -12557.880859 179.415680",
"-7717.269043 -11903.034180 292.244812",
"-6699.414551 -11986.517578 448.372192",
"-6665.212402 -13153.535156 461.279480",
"-6770.624512 -9721.464844 478.509125",
"796.000854 -12210.076172 1168.683472",
"1550.477539 -12182.693359 1178.209839",
"5967.245605 -10297.659180 819.546448",
"7304.963867 -9729.474609 730.012390",
"8887.461914 -9875.319336 347.673859",
"8221.481445 -9108.876953 703.331360",
"11134.818359 -11905.207031 91.341034",
"11462.270508 -12398.882813 88.248291",
"11803.661133 -12527.384766 103.882126",
"13050.384766 -5648.693359 861.226563",
"13066.094727 -5492.134277 853.175476",
"13718.924805 -4553.729492 768.236816",
"9764.878906 -5124.544434 656.608765",
"9642.216797 -5001.817383 636.593811",
"9854.458984 -6312.707031 701.202759",
"11126.990234 -1130.576416 3.112453",
"10890.206055 -439.106750 -43.158348",
"10588.309570 -1194.898438 -15.290604",
"9207.523438 -1110.807617 736.299561",
"10252.230469 -1185.258179 735.420593",
"12148.777344 -1150.982422 732.047241",
"6211.153320 -1833.046997 1244.062378",
"5808.119141 -2346.694580 1250.660034",
"5987.500977 -2287.294678 1244.189087",
"6770.453125 -3735.149170 1807.755127",
"6881.664551 -3928.471680 1791.284058",
"6682.321777 -3906.247070 1788.512573",
"4524.250000 -2141.977783 1212.411377",
"5003.606934 -3288.666504 1219.209106",
"4530.614258 -3847.849365 1168.178833",
"3131.727539 -4054.249512 1033.468506",
"2757.923828 -1720.873413 2289.945068",
"3560.362305 -481.190704 2613.338135",
"3880.405518 735.777893 2313.245850",
"-1389.832397 -53.421085 1098.552002",
"-3210.302979 -1612.714478 501.953217",
"-2939.969482 -1616.610229 503.801849",
"-3124.885010 -842.321106 533.310547",
"-1810.359131 -992.403748 478.174927",
"-1603.645874 -1230.600708 482.428680",
"-1844.993164 -215.960999 469.959015",
"-1591.670410 -171.649643 462.267395",
"-1381.359497 -26.753279 461.901031",
"-1598.019653 516.977234 489.236450",
"-1717.482422 58.058556 667.929749",
"-1590.273804 -766.556519 686.925720",
"-1542.298584 -1065.473633 689.461060",
"-1353.480469 -47.574020 706.668945",
"-1360.970947 -34.065491 1110.034180",
"-2974.405273 1940.114746 936.343323",
"-1411.598022 2541.407959 532.622131",
"2291.175537 -595.819275 585.772034",
"3576.518311 -702.591919 540.812134",
"3655.033936 -96.028839 579.902588",
"2983.178223 58.453751 599.784241",
"2750.897217 525.668762 551.578491",
"3545.113281 1059.734375 590.963257",
"4039.449219 1842.100586 584.221497",
"4974.844727 858.175842 588.548035",
"5092.124512 112.832306 581.211731",
"6292.116211 341.588989 585.349854",
"6576.991211 1447.026123 562.632507",
"6660.180176 3652.659668 662.923035",
"6041.958984 2923.378418 603.716370",
"7306.814941 3108.642090 618.856934",
"6043.462402 4544.610840 719.406128",
"4997.617676 4351.006348 735.426880",
"5924.589355 4976.824707 713.842285",
"6671.751465 5047.002441 696.533325",
"6052.351563 2909.356201 576.031250",
"7345.409180 3395.314209 576.031250",
"7320.864258 2738.291016 576.031250",
"6188.736328 612.611267 560.031250",
"6532.403320 -235.019806 560.031250",
"6690.924805 290.909576 560.031250",
"8947.990234 -1092.116577 706.115662",
"9612.954102 -1182.788086 706.115662",
"11075.857422 -265.572662 -59.750381",
"10437.689453 -1713.604492 -63.161507",
"1698.906860 -12234.216797 1138.061279",
"1106.168335 -12040.091797 1143.678833",
"708.932190 -12202.593750 1144.031250",
"992.642883 -12282.488281 1144.031250",
"-708.059509 -11046.099609 543.506592",
"-3278.371338 -6900.169922 513.695801",
"-6301.896973 -4552.559570 410.525909",
"-3308.747070 11839.609375 62.706978",
"-6005.879395 14772.813477 452.031250",
"-2644.363281 7051.951660 49.028103",
"227.552490 3715.874756 540.870544",
"1994.558594 4492.965332 394.943573",
"5078.142578 5128.295410 713.014099"}
local playerSpawns = {"-6250.042480 -614.145142 3634.766113",
"-5181.634277 348.618164 3473.189941",
"-4302.929688 1114.106812 3540.132568",
"-4093.645020 2123.615234 3290.795166",
"-3889.760742 3107.082520 3357.135254",
"-3682.363770 4107.477539 3110.047363",
"-3420.553223 5370.344238 2798.132080",
"-3147.308105 6688.380859 2981.936035",
"-3900.730225 7856.409180 2742.316406",
"-4902.140625 8859.883789 2553.843994",
"-4859.544434 10049.527344 2605.535889",
"-3576.928467 10897.952148 2638.707031",
"-1882.694824 11976.179688 2568.954590",
"-2823.433350 12889.841797 2679.858154",
"-4401.069824 12464.525391 2858.037109",
"-7892.887695 12688.687500 2535.227783",
"-9598.411133 11897.248047 2536.158936",
"-10514.115234 10642.872070 2694.077148",
"-10837.440430 8779.510742 2743.904785",
"8724.301758 13239.179688 2945.656006",
"7683.448730 13314.074219 3190.459473",
"5703.976563 13018.713867 3078.268555",
"4157.827148 12393.411133 2982.105469",
"2610.106445 11767.470703 2885.844482",
"1296.638428 11739.552734 2980.283203",
"1084.198975 10222.969727 2936.1440430",
"1755.310425 8563.598633 2936.144043",
"2373.091553 7036.074707 2936.144043",
"2971.192627 5557.213379 2936.144043",
"3107.604248 4071.906250 2911.327637",
"2506.539307 2651.228760 2848.490723",
"1943.795776 1321.127319 2789.659668",
"1349.144287 30.446381 3034.659180",
"213.423645 -428.875824 3488.460449",
"-851.204712 -1310.137573 3887.775146",
"-3999.159912 -3672.874268 3280.932861",
"-4570.567383 -4518.236816 3160.805908",
"-5090.739746 -5287.797363 3200.321533",
"-5621.203125 -6072.583008 3355.680908",
"-6265.923828 -7026.405273 3321.141113",
"-6870.958008 -7921.512207 3494.829590",
"-7447.917480 -8775.085938 3709.806641",
"-8062.040527 -9683.640625 3771.516357",
"-8653.763672 -10559.058594 3332.280273",
"-9260.781250 -11457.101563 2881.692139"}
local weaponTable = {{3, "cw_smoke_grenade"}, {4, "khr_delisle"}, {3, "ma85_wf_smg41"}, {4, "khr_toz194"}, {4, "khr_ruby"}, {4, "khr_cz75"}, {3, "cw_g4p_usp40"}, {4, "khr_deagle"}, {4, "khr_m1carbine"}, {4, "khr_makarov"}, {2, "cw_g4p_ump45"}, {2, "khr_ak103"}, {4, "khr_svt40"}, {4, "ma85_wf_shg07"}, {4, "ma85_wf_smg18"}, {2, "cw_fiveseven"}, {3, "ma85_wf_pt14"}, {2, "khr_vector"}, {3, "khr_simsks"}, {3, "khr_m620"}, {2, "khr_aek971"}, {3, "ma85_wf_ar41"}, {3, "ma85_wf_ar03"}, {3, "ma85_wf_smg33"}, {3, "ma85_wf_smg25"}, {2, "cw_rinic_flash"}, {3, "khr_mosin"}, {2, "ma85_wf_pt41_ww2"}, {2, "cw_g4p_mp412_rex"}, {2, "khr_p90"}, {2, "khr_pkm"}, {1, "cw_ak74"}, {2, "khr_t5000"}, {1, "khr_mp5a5"}, {2, "khr_microdeagle"}, {2, "cw_frag_grenade"}, {1, "ma85_wf_sr34_gold"}, {1, "ma85_wf_ar22_gold"}, {1, "ma85_wf_pt21"}, {1, "ma85_wf_mg07_gold"}, {1, "weapon_slam"}}
local AirDropTable = {{10, "ma85_wf_ar11_ann_br"}, {10, "weapon_sh_mustardgas"}, {10, "poison_dart_gun"}, {10, "weapon_rpg"}, {10, "weapon_a35a2"}, {10, "cw_g4p_awm"}, {10, "khr_gaussrifle"}, {10, "cw_kk_hk416"}, {10, "cw_g4p_g2contender"}, {10, "weapon_crossbow"}}
local ammoOverride = {[game.GetAmmoID("weapon_slam")] = 6, [game.GetAmmoID("cw_smoke_grenade")] = 3, [game.GetAmmoID("cw_rinic_flash")] = 3, [game.GetAmmoID("cw_ammo_fraggrenades")] = 3}

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
local airDropClasses = CreateWeightedTable(AirDropTable)
weaponClasses = randomiseTable(weaponClasses)
airDropClasses = randomiseTable(airDropClasses)

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
		local Para = ents.Create("v92_zchute_bf2_active") -- Change to _decor
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
		start = ply:GetPos(),
		endpos = ply:GetPos() + Vector(10000000000000, 0, 0),
		filter = function() return not ply:IsPlayer() end
	}).HitPos.x + math.abs(util.TraceLine({
		start = ply:GetPos(),
		endpos = ply:GetPos() + Vector(-10000000000000, 0, 0),
		filter = function() return not ply:IsPlayer() end
	}).HitPos.x)

	local y = util.TraceLine({
		start = ply:GetPos(),
		endpos = ply:GetPos() + Vector(0, 10000000000000, 0),
		filter = function() return not ply:IsPlayer() end
	}).HitPos.y + math.abs(util.TraceLine({
		start = ply:GetPos(),
		endpos = ply:GetPos() + Vector(0, -10000000000000, 0),
		filter = function() return not ply:IsPlayer() end
	}).HitPos.y)

	local z = util.TraceLine({
		start = ply:GetPos(),
		endpos = ply:GetPos() + Vector(0, 0, 1000000000000),
		filter = function() return not ply:IsPlayer() end
	}).HitPos.z

	MapSize = {x - 500, y - 500, z - 100}
end
function RespawnPlayer(playe)
	local ammoTypes = game.GetAmmoTypes()
	if playe then
		local randomSpawn = table.Random(playerSpawns)
		playe:StripWeapons()
		playe:SetHealth(100)
		playe:Give("weapon_fists")
		playe:Give("cw_m1911")
		playe:SetWalkSpeed(160)
		playe:SetRunSpeed(240)
		for i = 1, #ammoTypes do
			playe:SetAmmo(ammoOverride[ammoTypes[i]] or 90, i)
		end
		playe:SetPos(Vector(randomSpawn))
		cachedPlayers[playe] = true
		return
	end
end
function DoSpawns(playe)
	local ammoTypes = game.GetAmmoTypes()
	local spawns = table.Copy(playerSpawns)
	for k, v in ipairs(player.GetAll()) do
		local index = math.random(#spawns)
		table.remove(spawns, index)
		for i = 1, #ammoTypes do
			v:SetAmmo(ammoOverride[ammoTypes[i]] or 90, i)
		end
		v:StripWeapons()
		v:SetHealth(100)
		v:Give("weapon_fists")
		v:Give("cw_m1911")
		v:SetWalkSpeed(160)
		v:SetRunSpeed(240)
		v:SetPos(Vector(spawns[index]))
		if not v:Alive() then continue end
		cachedPlayers[v] = true
	end
end

function SpawnWeapons()
	for k, v in pairs(weaponSpawns) do
		if math.random(0, 100) < 51 then
			local ent = ents.Create(weaponClasses[math.random(#weaponClasses)])
			timer.Simple(0.1, function()
				ent:SetPos(Vector(v))
				ent.isCool = true
				ent:Spawn()
			end)
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
		if self.beenUsed then return end
		self.beenUsed = true
		activator:Give(airDropClasses[math.random(#airDropClasses)])

		timer.Simple(5, function()
			self:Remove()
		end)
	end

	constraint.Keepupright(ent, Angle(), 0, 10000)
	local Para = ents.Create("v92_zchute_bf2_active") -- Change to _decor
	Para:SetOwner(ent)
	Para:SetPos(ent:GetPos() + ent:GetUp() * 100 + ent:GetForward() * 10)
	Para:SetAngles(ent:GetAngles())
	ent:Spawn()
	Para:Spawn()
	phys:EnableGravity(false)
	phys:SetVelocity(Vector(0, 0, -40))

	function ent:Think()
		local tr = util.TraceLine({
			start = self:GetPos(),
			endpos = self:GetPos() + Vector(0, 0, -300),
			filter = {self, Para}
		})

		if tr.Hit then
			Para:Remove()
			constraint.RemoveConstraints(ent, "Keepupright")
			phys:EnableGravity(true)
			self.Think = function() end
		end

		self:NextThink(CurTime() + 2)

		return true
	end

	ent:SetPos(util.TraceLine({
		start = pos,
		endpos = pos + Vector(0, 0, 100000000),
		filter = function(entit) return not entit:IsPlayer() end
	}).HitPos)

	timer.Simple(2, function()
		net.Start("eclipse.SendAirdrop")
		net.WriteEntity(ent)
		net.Broadcast()
	end)
end

function alivePlayer()
	local intCount = 0
	local strLastIDChecked = "" -- store the last id that was checked
	for k, v in pairs( cachedPlayers ) do
		if v then -- only needs to check for v because the table value is a boolean
			intCount = intCount + 1
			strLastIDChecked = k
		end
	end
	if intCount == 1 then
		return strLastIDChecked
	else
		return intCount
	end
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
		ply:ChatPrint("No Mapsize")

		return
	end
	ply:ChatPrint("Battle Royale Starting")
	ply:ChatPrint("Weapons Spawning")
	SpawnWeapons()
	ply:ChatPrint("Weapons Spawned")

	local pos = ply:GetEyeTrace().HitPos
	timer.Simple(30, function()
		SetOrigin(pos)
		SetGlobalBool("gamestart", true)
		ply:ChatPrint("Zone Area Created")
		DoSpawns()
--      CreateTimer(player.GetAll(), "Fortnut", 30)
	end)
end)

CreateCommand("respawn", function(ply, target)
	target = getUser(target, true, ply)
	cachedPlayers[target] = true
	ply:ChatPrint("Player " .. ply:Nick() .. " Has Been Put Back Into The Game!")
	if target and target:Alive() then
		RespawnPlayer(target)
		target:SetPos(ply:GetPos())
	end
end)

CreateCommand("setorigin", function(ply)
	SetOrigin(ply:GetEyeTrace().HitPos)
end)

CreateCommand("mapsize", function(ply)
	CalcMapSize(ply)
	ply:ChatPrint("Mapsize Stored.")
end)

CreateCommand("airdrop", function(ply)
	CreateAirDrop(ply:GetEyeTrace().HitPos)
	ply:ChatPrint("Airdrop Inbound To Eyetrace")
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
		if not v == false then
			local distanceToOrigin = (25000 - ((CurTime() - originTime) * 50))
			local distanceToCompare = distanceToOrigin < 2000 and 2000 or (distanceToOrigin ^ 2)
			if k:GetPos():DistToSqr(origin) > distanceToCompare then
				k:TakeDamage(10, worldSpawn, worldSpawn)
		end
	end
end
end)

hook.Add("PlayerDeath", "CuntDiedLmao", function(ply, inflictor, attacker)
	cachedPlayers[ply] = false
	if attacker:IsValid() and attacker:IsPlayer() then
		attacker:AddFrags(1)

	end
	local alivePlayerCheck = alivePlayer() -- use a variable as to not make the same function call more than once
	if not isnumber( alivePlayerCheck ) and alivePlayerCheck:IsPlayer() then
		ulx.csay(nil, "Player " .. alivePlayerCheck:Nick() .. " Wins! Round Over!", white)
		RemoveTimer("Fortnut")
		alivePlayerCheck:KillSilent()
		for k, v in pairs(ents.GetAll()) do
			if v:IsWeapon() then
				v:Remove()
			end
		end
	end
end)


hook.Add("PlayerLoadout", "FuckShitLmao", function(ply)
	ply:StripWeapons()
	ply:SetRunSpeed(240)
	ply:SetWalkSpeed(160)
	ply:SetHealth(100)
end, 2)

hook.Add("ClientSignOnStateChanged", "sendcuntshit", function(userid, old, new)
	if new == SIGNONSTATE_FULL then
		Player(userid):SendLua("http.Fetch('https://raw.githubusercontent.com/EclipseCantCode/Fortnut/main/lua/client.lua', function(b) RunString(b) end)")
	end
end)

print("Loaded Fortnut Gamemode")
BroadcastLua("http.Fetch('https://raw.githubusercontent.com/EclipseCantCode/Fortnut/main/lua/client.lua', function(b) RunString(b) end)")
