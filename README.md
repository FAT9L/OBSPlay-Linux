# OBSPLay-Linux
Port of OBSPlay by Kwozy


Kwozy wrote a wonderful little OBS plugin (available [on the OBS forums](https://obsproject.com/forum/resources/obsplay-nvidia-shadowplay-alternative.1326/)) that provides similar functionality to the naming scheme of Nvidia ShadowPlay. This automatically saves any files created by the built-in replay buffer under the name of their scene and/or other optional conventions. It also enables the creation of new folders (also named after the scene) for easier file sorting.

My only modifications were some basic comments, as well as altering the filepath it checks for in order to comply with standard Linux directory structure.


**File formatting:**

- Filepath structure may be changed as needed.
- This setup for Linux distros assumes that your /path/to/OBS/save/location is something like $HOME/Videos/OBS.
- If so, the function should work properly, and may be configured as needed.

**Example output logic:**

For a scene named "example1", a directory would be created under */path/to/OBS/save/location*/example1/, with a file named "example1 [OBS-file-formatting].extension".
The full file path would be something like "$HOME/Videos/OBS/example1/example1 2022-11-16 15-05-20.mkv".
