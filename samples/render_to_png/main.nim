import nimtralight_sys

var done {.global.} = false

const htmlString = """
  <html>
    <head>
      <style type="text/css">
        body {
          margin: 0;
          padding: 0;
          overflow: hidden;
          color: black;
          font-family: Arial;
          background: linear-gradient(-45deg, #acb4ff, #f5d4e2);
          display: flex;
          justify-content: center;
          align-items: center;
        }
        div {
          width: 350px;
          height: 350px;
          text-align: center;
          border-radius: 25px;
          background: linear-gradient(-45deg, #e5eaf9, #f9eaf6);
          box-shadow: 0 7px 18px -6px #8f8ae1;
        }
        h1 {
          padding: 1em;
        }
        p {
          background: white;
          padding: 2em;
          margin: 40px;
          border-radius: 25px;
        }
      </style>
    </head>
    <body>
      <div>
        <h1>Hello World!</h1>
        <p>Welcome to Nimtralight!</p>
      </div>
    </body>
  </html>
  """

proc destroyStrs(strs: varargs[ULString]) =
  for str in strs:
    str.ulDestroyString

proc onFinish(userData: pointer, called: ULView, frameId: culonglong,
    isMainFrame: bool, url: ULString) {.cdecl.} =
  if isMainFrame:
    echo "Our page has loaded!"
    done = true

var
  config = ulCreateConfig()
  fontName = "Arial".ulCreateString
  resourcePath = "./resources/".ulCreateString
  baseDir = "./assets/".ulCreateString
  logPath = "ultralight.log".ulCreateString
  html = htmlString.ulCreateString

config.ulConfigSetDeviceScale(2.0)
config.ulConfigSetFontFamilyStandard(fontName)
config.ulConfigSetResourcePath(resourcePath)
config.ulConfigSetUseGPURenderer(false)
destroyStrs(fontName, resourcePath)

ulEnablePlatformFontLoader()
baseDir.ulEnablePlatformFileSystem()
logPath.ulEnableDefaultLogger()
destroyStrs(baseDir, logPath)

var
  renderer = config.ulCreateRenderer()
  view = renderer.ulCreateView(1600, 1600, false, nil, false)

view.ulViewSetFinishLoadingCallback(onFinish, nil)
view.ulViewLoadHTML(html)
destroyStrs(html)

echo "Starting Run(), waiting for page to load..."

while not done:
  renderer.ulUpdate
  renderer.ulRender

var
  surface = view.ulViewGetSurface
  bitmap = surface.ulBitmapSurfaceGetBitmap
bitmap.ulBitmapSwapRedBlueChannels()
discard bitmap.ulBitmapWritePNG("result.png")
echo "Saved a render of our page to result.png."
echo "Finished."
