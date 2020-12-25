## Installation

1. Clone this repository `git clone git@github.com:svenrdz/nimtralight.git ~`
2. [Download the latest Ultralight release for your platform.](https://github.com/ultralight-ux/Ultralight/releases) and place them in the right folder, depending on the OS. (for macOS I copied each .dylib file to `/usr/local/lib/`)
3. Go inside the cloned folder `cd ~/nimtralight`
5. Run `nimble wrap` to generate the wrapper code (better for autocompletion support)

You can run the samples using nimble tasks `nimble png` / `nimble basic`, the generated binary will be inside the `build` folder.
