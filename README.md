# OBSPlay-Linux
Linux-compatible fork/port of [OBSPlay](https://obsproject.com/forum/resources/obsplay-nvidia-shadowplay-alternative.1326/) by Kwozy.


Provides similar functionality to the naming scheme of Nvidia ShadowPlay. This automatically saves any files created by the built-in replay buffer under the name of their scene, followed by any optional conventions you've set in OBS. It also enables the creation of new folders (also named after the scene) for easier file sorting.

My modifications alter the filepath that this script checks for, in order to comply with standard Linux directory structure.


#### **Example output logic with scene prefix and scene folder:**

Assuming that your `/path/to/OBS/save/location` is something like `$HOME/Videos/OBS`, with a scene named `example1`, a directory would be created under `/path/to/OBS/save/location/example1/`, with a file named `example1 [OBS-file-formatting].extension`.

The full file path would be something like `$HOME/Videos/OBS/example1/example1 2022-11-16 15-05-20.mkv`.


## **Installation:**

- `git clone` this repo (or your preferred method)
- Extract `OBSPlay-Linux.lua`
- Save to your plugins directory, most likely `/usr/share/obs/obs-plugins/frontend-tools/scripts`
- Test as needed
