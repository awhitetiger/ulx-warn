CATEGORY_NAME = "SammyServers Extra"


function ulx.warn(calling_ply, target_ply, reason)
	if SERVER then
		if target_ply:GetPData("warn_data") == nil then
			target_ply:SetPData("warn_data", 1)
		elseif tonumber(target_ply:GetPData("warn_data")) == 2 then
			target_ply:SetPData("warn_data", target_ply:GetPData("warn_data") + 1)
			target_ply:Kick("Auto kick for 3rd warning.")
		elseif tonumber(target_ply:GetPData("warn_data")) > 2 then
			target_ply:SetPData("warn_data", target_ply:GetPData("warn_data") + 1)
			target_ply:Kick("Auto kick for any warning after 3rd.")
		else
			target_ply:SetPData("warn_data", target_ply:GetPData("warn_data") + 1)
		end
		ulx.fancyLogAdmin(calling_ply, "#A warned #T for #s", target_ply, reason)
	end
end
local warn = ulx.command(CATEGORY_NAME, "ulx warn", ulx.warn, "!warn")
warn:addParam{type=ULib.cmds.PlayerArg, target="!^", ULib.cmds.ignoreCanTarget}
warn:addParam{type=ULib.cmds.StringArg, hint="Reason for warning."}
warn:defaultAccess(ULib.ACCESS_ADMIN)
warn:help("Warns the target.")

function ulx.removewarn(calling_ply, target_ply)
	if SERVER then
		if target_ply:GetPData("warn_data") == nil then
			print("User has no warnings.")
		else
			target_ply:SetPData("warn_data", ply:GetPData("warn_data") - 1)
		end
		ulx.fancyLogAdmin(calling_ply, "#A removed a warning from #T", target_ply)
	end
end
local removewarn = ulx.command(CATEGORY_NAME, "ulx removewarn", ulx.removewarn, "!removewarn")
removewarn:addParam{type=ULib.cmds.PlayerArg, target="!^", ULib.cmds.ignoreCanTarget}
removewarn:defaultAccess(ULib.ACCESS_ADMIN)
removewarn:help("Removes a warning from the target.")