import nimtralight

var
  overlay {.global.}: ULOverlay
  view {.global.}: ULView

proc getMessage(ctx: JSContextRef, function: JSObjectRef;
    thisObject: JSObjectRef, argumentCount: uint, arguments: UncheckedArray[
    JSValueRef], exception: ptr JSValueRef): JSValueRef {.cdecl.} =
  var
    str = "Hello from nim!".JSStringCreateWithUTF8CString
    value = JSValueMakeString(ctx, str)
  str.JSStringRelease
  return value

callback ULUpdateCallback:
  proc onUpdate = discard

callback ULResizeCallback:
  proc onResize =
    overlay.resize(width, height)

callback ULDOMReadyCallback:
  proc onDOMReady =
    var
      ctx = view.lockJSContext
      name = "GetMessage".JSStringCreateWithUTF8CString
      fun = JSObjectMakeFunctionWithCallback(ctx, name, getMessage)
    JSObjectSetProperty(ctx, JSContextGetGlobalObject(ctx), name, fun, 0, nil)
    name.JSStringRelease
    view.unlockjsContext

var settings = newSettings()
settings.forceCPURenderer = true

var
  config = newConfig()
  app = settings.createApp(config)

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
view.loadURL("file:///app.html")

app.run

overlay.destroyOverlay
window.destroyWindow
app.destroyApp
