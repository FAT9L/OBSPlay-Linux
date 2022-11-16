-- OBSPlay-Linux: Shadow play functionality for *nix systems
-- Copyright (C) 2022 by FAT9L 

    -- This program is free software: you can redistribute it and/or modify
    -- it under the terms of the GNU General Public License as published by
    -- the Free Software Foundation, either version 3 of the License, or
    -- (at your option) any later version.

    -- This program is distributed in the hope that it will be useful,
    -- but WITHOUT ANY WARRANTY; without even the implied warranty of
    -- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    -- GNU General Public License for more details.

    -- You should have received a copy of the GNU General Public License
    -- along with this program.  If not, see <https://www.gnu.org/licenses/>.



-- v1.0.0


o = obslua

BASEDIRECTORY= nil
sceneBasedName = false
sceneBasedFolder = false

function script_description()
	return [[OBSPlay, like Nvidia Shadowplay but for OBS! If you have Scene Based Prefix Enabled it will move the replay file to the 'Base Save Path' and rename the file to have a prefix of the scene name. 
If you have 'Scene Based Folder' it will move the replay file to 'BaseSavePath/SceneName' and will not change the prefix. 
Enable both to have it change the Prefix and move the recording to the 'Scene Based Folder'.
IMPORTANT: Leave Your Replay Buffer Prefix empty if you are using Scene Based Prefix.

Author: Kwozy]]

end

function script_load()

	o.obs_frontend_add_event_callback(obs_frontend_callback)

end

function script_unload()
   
end


-- Function separates replay path from its name
-- Example: $HOME/Videos/Replay File Name -> Replay File Name 
-- Confirmed to work on Debian 12 Unstable
function get_replay_name(path)

   return path:match( "([^/]+)$" )

end


-- Function To Retrive The Latest Replay
function get_last_replay()
    replay_buffer = o.obs_frontend_get_replay_buffer_output()
    cd = o.calldata_create()
    ph = o.obs_output_get_proc_handler(replay_buffer)
    o.proc_handler_call(ph, "get_last_replay", cd)
    path = o.calldata_string(cd, "path")
    o.calldata_destroy(cd)
    o.obs_output_release(replay_buffer)
    return path
end
	
function get_current_scene_name()
	current_scene = o.obs_frontend_get_current_scene()
	name = o.obs_source_get_name(current_scene)
	o.obs_source_release(current_scene)
	return name
end 

-- Function Called By OBS
function obs_frontend_callback(event, private_data)
	if event == o.OBS_FRONTEND_EVENT_REPLAY_BUFFER_SAVED then 
        OBSPlay()
    end
end


-- The Main Program

-- Filepath structure may be changed as needed.
-- This setup for Linux distros assumes that your /path/to/OBS/save/location is something like $HOME/Videos/OBS
-- If so, the function should work properly.

-- Example output:
-- For a scene named "scene1", a directory would be created under $HOME/Videos/OBS/scene1,
-- with a file named "scene1 YYYY-MM-DD HH-MM-SS.extension".
-- The full file path would be something like "$HOME/Videos/OBS/scene1/scene1 2022-11-16 15-05-20.mkv".

function OBSPlay()
		last_Replay = get_last_replay()
		current_scene_name = get_current_scene_name()
		absBasePath = o.os_get_abs_path_ptr(BASEDIRECTORY)

	if last_Replay ~= nil then
		last_Replay_Name = get_replay_name(last_Replay)
			if sceneBasedName == true and sceneBasedFolder == true then
				
				if o.os_file_exists(absBasePath .. '/' .. current_scene_name) == true then 	
				o.os_rename(last_Replay, absBasePath .. '/' .. current_scene_name .. '/'.. current_scene_name .. " " .. last_Replay_Name) 
				else
					o.os_mkdir(absBasePath .. '/' .. current_scene_name .. '/')	
					o.os_rename(last_Replay, absBasePath .. '/' .. current_scene_name .. '/'.. current_scene_name .. " " .. last_Replay_Name) 
				end
			elseif sceneBasedName == true then
				o.os_rename(last_Replay, absBasePath .. '/' .. current_scene_name .. " " .. last_Replay_Name) 
			elseif sceneBasedFolder == true then
				o.os_rename(last_Replay, absBasePath .. '/' .. current_scene_name .. '/' .. last_Replay_Name) 
			end
		end
	end

function script_properties()
    local p = o.obs_properties_create()

    o.obs_properties_add_path(p, "baseSavePath", "Base Save Path",
        o.OBS_PATH_DIRECTORY,
        nil,
        nil
    )
	o.obs_properties_add_bool(p, "sceneBasedPrefix", "Scene Based File Prefix")
	o.obs_properties_add_bool(p, "sceneBasedDir", "Scene Based Folder")

    return p
end

function script_defaults(s)
	o.obs_data_set_default_bool(s, "sceneBasedPrefix", sceneBasedName)
	o.obs_data_set_default_bool(s, "sceneBasedDir", sceneBasedFolder)
end

function script_update(s)
    BASEDIRECTORY = o.obs_data_get_string(s, "baseSavePath")
	sceneBasedName = o.obs_data_get_bool(s, "sceneBasedPrefix")
	sceneBasedFolder = o.obs_data_get_bool(s, "sceneBasedDir")
end
