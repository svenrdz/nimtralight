import os
import nimtralight

const html = """
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

# proc onFinish(userData: pointer, called: ULView, frameId: culonglong,
#     isMainFrame: bool, url: ULString) {.cdecl.} =
callback ULFinishLoadingCallback:
  proc onFinish =
    if isMainFrame:
      echo "Our page has loaded!"

var config = initConfig()
config.deviceScale = 2.0
config.fontFamilyStandard = "Arial"
config.resourcePath = currentSourcePath.parentDir.parentDir.parentDir / "sdk" /
    "bin" / "resources"
config.useGpuRenderer = false

enablePlatformFontLoader()
enablePlatformFileSystem(ul"./assets/")
enableDefaultLogger(ul"ultralight.log")

var
  renderer = config.createRenderer()
  view = renderer.createView(1600, 1600, false, nil, false)

view.setFinishLoadingCallback(onFinish, nil)
view.loadHTML(html.ul)

echo "Starting Run(), waiting for page to load..."

while view.isLoading:
  renderer.update
  renderer.render

var
  surface = view.getSurface
  bitmap = surface.getBitmap
bitmap.swapRedBlueChannels()
discard bitmap.writePNG("result.png")
echo "Saved a render of our page to result.png."
echo "Finished."
