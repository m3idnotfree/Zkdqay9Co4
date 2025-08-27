local mp = require("mp")
local utils = require("mp.utils")
local msg = require("mp.msg")

local function detect_os()
	if package.config:sub(1, 1) == "\\" then
		return "windows"
	else
		local handle = io.popen("uname -s 2>/dev/null")
		if handle then
			local result = handle:read("*a"):gsub("%s+", "")
			handle:close()
			if result == "Darwin" then
				return "macos"
			elseif result == "Linux" then
				return "linux"
			else
				return "unix"
			end
		end
	end
	return "unknown"
end

local function reveal_file_manager()
	local path = mp.get_property("path")

	if not path then
		msg.warn("No file currently playing")
		mp.osd_message("No file loaded", 2)
		return
	end

	if path:match("^https?://") or path:match("^ftp://") or path:match("^rtmp://") then
		msg.info("Cannot open file manager for network streams")
		mp.osd_message("Cannot reveal network streams", 3)
		return
	end

	path = mp.command_native({ "expand-path", path })
	local os = detect_os()
	local args = {}
	local filename = path:match("[^/\\]+$") or path

	if os == "windows" then
		args = { "explorer", "/select," .. path:gsub("/", "\\") }
	elseif os == "macos" then
		args = { "open", "-R", path }
	elseif os == "linux" then
		local managers = {
			{ "nautilus", "--select", path }, -- GNOME
			{ "dolphin", "--select", path }, -- KDE
			{ "thunar", path }, -- XFCE
			{ "nemo", "--select", path }, -- Cinnamon
			{ "pcmanfm", path }, -- LXDE
			{ "caja", path }, -- MATE
		}

		for _, manager in ipairs(managers) do
			local test = utils.subprocess({ args = { "which", manager[1] }, capture_stdout = true })
			if test.status == 0 then
				args = manager
				break
			end
		end

		if #args == 0 then
			local dir = utils.split_path(path)
			args = { "xdg-open", dir }
			msg.info("No file manager with selection support found, opening directory")
		end
	else
		msg.error("Unsupported operating system: " .. os)
		mp.osd_message("Unsupported OS: " .. os, 3)
		return
	end

	if #args > 0 then
		mp.osd_message("Opening file manager...", 1)

		local result = utils.subprocess({ args = args, detach = true })
		if result then
			msg.info("Opening file manager (" .. os .. ") to: " .. path)
			mp.osd_message("Revealed: " .. filename, 2)
		else
			msg.error("Failed to open file manager")
			mp.osd_message("Failed to open file manager", 3)
		end
	else
		msg.error("No suitable file manager found")
		mp.osd_message("No file manager available", 3)
	end
end

mp.remove_key_binding("z")
mp.add_key_binding("z", "reveal-file", reveal_file_manager) -- Primary key
mp.register_script_message("reveal-file", reveal_file_manager)
