origin = origin or nil
originTime = originTime or nil

net.Receive("eclipse.SendOrigin", function()
	originTime, origin = net.ReadFloat(), net.ReadVector()
end)

hook.Add("PostDrawTranslucentRenderables", "DrawFuckedCunts", function()
	if GetGlobalBool("gamestart") and origin and originTime then
		render.DrawWireframeSphere(origin, 20000 - ((CurTime() - originTime) * 100), 50, 50, Color(0, 217, 255), true)
	end
end)

chat.AddText("Loaded Clientside fortnut")