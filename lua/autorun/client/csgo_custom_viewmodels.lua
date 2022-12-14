CreateClientConVar("cl_righthand", 1, true, false, "")
CreateClientConVar("viewmodel_offset_x", 0, true, false, "")
CreateClientConVar("viewmodel_offset_y", 0, true, false, "")
CreateClientConVar("viewmodel_offset_z", 0, true, false, "")

hook.Add("Think", "CSGO_Custom_ViewModels_Think", function()
	local localplayer = LocalPlayer()
	local wep = localplayer:GetActiveWeapon()

	if !IsValid(wep) then return end

	if !isbool(wep.OldViewModelFlip) then
		wep.OldViewModelFlip = wep.ViewModelFlip or false
	end

	if tobool(GetConVar("cl_righthand"):GetInt()) then
		wep.ViewModelFlip = wep.OldViewModelFlip
	else
		wep.ViewModelFlip = !wep.OldViewModelFlip
	end
end)

hook.Add("CalcViewModelView", "CSGO_Custom_ViewModels_CalcViewModelView", function(wep, vm, oldPos, oldAng, pos, ang)
	local offset = Vector(GetConVar("viewmodel_offset_x"):GetFloat(), GetConVar("viewmodel_offset_y"):GetFloat(), GetConVar("viewmodel_offset_z"):GetFloat())

	offset:Rotate(ang)

	return pos + offset, ang
end)
