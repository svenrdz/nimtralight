## Installation

1. Clone this repository `git clone git@github.com:svenrdz/nimtralight.git ~`
2. [Download the latest Ultralight release for your platform.](https://github.com/ultralight-ux/Ultralight/releases)
3. `cd ~/nimtralight`
4. Create a folder `sdk` at the root of this repo and extract the SDK archive inside it.
5. `nimble develop`

## Running a sample

### Linux
```
cd samples/Sample\ 1\ -\ Render\ to\ PNG
LD_LIBRARY_PATH="../../sdk/bin" nim c -r main
```

### Windows
```
cp -r sdk\bin\* '.\samples\Sample 1 - Render to PNG'
cd .\samples\Sample 1 - Render to PNG
nim c -r main
```

### MacOsX
```
cd samples/Sample\ 1\ -\ Render\ to\ PNG
# for some reason using `-r` with DYLD_LIBRARY_PATH does not work...
nim c main
DYLD_LIBRARY_PATH="../../sdk/bin" ./main
```
