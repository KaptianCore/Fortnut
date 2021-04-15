local origin, originTime

net.Receive("eclipse.SendOrigin", function()
	originTime, origin = net.ReadFloat(), net.ReadVector()
end)

hook.Add("PostDrawTranslucentRenderables", "DrawFuckedCunts", function()
	if GetGlobalBool("gamestart") then
		render.DrawWireframeSphere(origin, 20000 - ((CurTime() - originTime) * 100), 50, 50)
	end
end)

chat.AddText("Loaded Clientside fortnut")