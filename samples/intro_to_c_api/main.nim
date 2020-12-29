import os
import nimtralight

when defined(gcDestructors):
  echo "hello"

var
  overlay {.global.}: ULOverlay
  view {.global.}: ULView

callback JSObjectCallAsFunctionCallback:
  proc getMessage =
    result = ctx.JSValueMakeString js"Hello from nim!"

callback ULUpdateCallback:
  proc onUpdate = discard

callback ULResizeCallback:
  proc onResize =
    overlay.resize(width, height)

callback ULDOMReadyCallback:
  proc onDOMReady =
    var
      ctx = view.lockJSContext
      name = js"GetMessage"
      fun = JSObjectMakeFunctionWithCallback(ctx, name, getMessage)
      globalObj = ctx.JSContextGetGlobalObject
    ctx.JSObjectSetProperty(globalObj, name, fun, 0, nil)
    view.unlockjsContext

var settings = initSettings()
settings.forceCPURenderer = true
enableDefaultLogger(ul"ultralight.log")

var config = initConfig()
config.resourcePath = (currentSourcePath.parentDir.parentDir.parentDir / "sdk" /
    "bin" / "resources").s16
var app = settings.createApp(config)

app.setUpdateCallback(onUpdate, nil)

var
  monitor = app.getMainMonitor
  window = monitor.createWindow(500, 500, false, {wfTitled, wfResizable})
window.setTitle("Ultralight Sample 6 - Intro to C API")
window.setResizeCallback(onResize, nil)
app.setWindow(window)
overlay = window.createOverlay(window.width, window.height, 0, 0)
view = overlay.getView
view.setDOMReadyCallback(onDOMReady, nil)
view.loadURL(ul"file:///app.html")

app.run

overlay.destroyOverlay
window.destroyWindow
app.destroyApp
