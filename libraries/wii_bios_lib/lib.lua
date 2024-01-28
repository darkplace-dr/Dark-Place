local Lib = {}

function Lib:init()
	local load_string = "Deactivated"
	self.wii_data = false
	if Kristal.load_wii then
		load_string = "Activated"
		if love.filesystem.getInfo("wii_settings.json") then
			self.wii_data = JSON.decode(love.filesystem.read("wii_settings.json"))
		else
			error("[Wii BIOS] Mod said we were in Wii mode, but wii_settings.json doesn't exist.")
		end
	end
	print("[Wii BIOS] Wii BIOS Library loaded. Wii mode: " .. load_string)
end

function Lib:messageBoard(message, title)
	if Kristal.load_wii then
		if not message then
			error("[Wii BIOS] Tried to send a message, but none existed.")
			return
		end
		
		local fm = {
			["title"] = title or Mod.info.name,
			["message"] = message,
			["mod"] = Mod.info.id,
			["opened"] = false,
			["date"] = os.date("%m/%d/%Y")
		}
		
		local size = 1
		for _ in pairs(self.wii_data["messages"])	do
			size = size + 1
		end
		
		self.wii_data["messages"][size] = fm
		love.filesystem.write("wii_settings.json", JSON.encode(self.wii_data))
	end
end

return Lib