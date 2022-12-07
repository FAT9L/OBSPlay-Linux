# OBSPlay-Linux
Linux-compatible fork/port of [OBSPlay](https://obsproject.com/forum/resources/obsplay-nvidia-shadowplay-alternative.1326/) by Kwozy.


Provides similar functionality to the naming scheme of Nvidia ShadowPlay. This automatically saves any files created by the built-in replay buffer under the name of their scene, followed by any optional conventions you've set in OBS. It also enables the creation of new folders (also named after the scene) for easier file sorting.

My modifications alter the filepath that this script checks for, in order to comply with standard Linux directory structure.

### **Advanced Scene Switcher integration:**

Also listed in this repo is a drop-in configuration file for the [Advanced Scene Switcher](https://obsproject.com/forum/resources/advanced-scene-switcher.395/) plugin (AUR: [obs-advanced-scene-switcher](https://aur.archlinux.org/packages/obs-advanced-scene-switcher)), which adds a couple of macros to automate saving replay segments. It works by saving the replay buffer, allowing a few seconds to pass, then restarting the buffer. This allows the user to save several segments in a row without overlap. 

Normally, OBS will save replay buffer segments as follows:

    00:00:00 - The replay buffer starts, and is recording 5 minutes of footage at a time.
    00:06:00 - I press my "save recording" hotkey, which captures 5 minutes (00:01:00 - 00:06:00)
    00:07:00 - I hit the hotkey again, which captures 5:00 minutes (00:02:00 - 00:07:00)
    00:13:00 - I hit the hotkey again, which captures 5:00 minutes (00:08:00 - 00:13:00)

By utilizing the macro, the following behavior can be achieved instead:

    00:00:00 - The replay buffer starts, and is recording 5 minutes of footage at a time.
    00:06:00 - I press my "save recording" hotkey, which captures 5:00 minutes (00:01:00 - 00:06:00)
    00:07:00 - I hit the hotkey again, which captures ≤ 5 minutes (00:06:00 - 00:07:00)
    00:13:00 - I hit the hotkey again, which captures ≤ 5 minutes (00:08:00 - 00:13:00)

This is set up to trigger with `Macro trigger hotkey 1`, which I've bound to F10 by default here.

As a warning, this does inherently lose about 8 seconds during the window in which the buffer contents are being saved, and while the buffer restarts. This is unavoidable. However, the benefits most likely outweigh the cost if you find yourself frequently having to skip through redundant footage later on.


### **Example output logic with scene prefix and scene folder:**

Assuming that your `/path/to/OBS/save/location` is something like `$HOME/Videos/OBS`, with a scene named `example1`, a directory would be created under `/path/to/OBS/save/location/example1/`, with a file named `example1 [OBS-file-formatting].extension`.

The full file path would be something like `$HOME/Videos/OBS/example1/example1 2022-11-16 15-05-20.mkv`.


## **Installation:**

- `git clone https://github.com/FAT9L/OBSPlay-Linux.git`
- Copy `OBSPlay-Linux.lua` to your plugins directory, most likely `/usr/share/obs/obs-plugins/frontend-tools/scripts`
- Optional: use the `adv-ss-OBSPlay-integration.txt` config (OBS > Tools > Advanced Scene Switcher > Save/load settings > Import)
- Test as needed
