import nimtralight_sys

var
  overlay {.global.}: ULOverlay
  view {.global.}: ULView

proc getMessage(ctx: JSContextRef, function: JSObjectRef;
    thisObject: JSObjectRef, argumentCount: uint, arguments: UncheckedArray[
    JSValueRef], exception: ptr JSValueRef): JSValueRef {.cdecl.} =
  var
    str = "Hello from nim!".jsStringCreateWithUTF8CString
    value = JSValueMakeString(ctx, str)
  str.JSStringRelease
  return value

proc onUpdate(userData: pointer) {.cdecl.} = discard

proc onResize(userData: pointer, width: cuint, height: cuint) {.cdecl.} =
  overlay.resize(width, height)

proc onDOMReady(userData: pointer, caller: ULView, frameId: culonglong,
    isMainFrame: bool, url: ULString) {.cdecl.} =
  var
    ctx = view.lockJSContext
    name = "GetMessage".JSStringCreateWithUTF8CString
    fun = JSObjectMakeFunctionWithCallback(ctx, name, getMessage)
  JSObjectSetProperty(ctx, JSContextGetGlobalObject(ctx), name, fun, 0, nil)
  name.JSStringRelease
  view.unlockjsContext

var settings = createSettings()
settings.setForceCPURenderer(true)

var
  config = createConfig()
  app = settings.createApp(config)

app.setUpdateCallback(onUpdate, nil)
settings.destroySettings
config.destroyConfig

var
  monitor = app.getMainMonitor
  window = monitor.createWindow(500, 500, false,
    kWindowFlags_Titled.cuint) #| kWindowFlags_Resizable)
window.setTitle("Ultralight Sample 6 - Intro to C API")
window.setResizeCallback(onResize, nil)
app.setWindow(window)
overlay = window.createOverlay(window.getWidth, window.getHeight, 0, 0)
view = overlay.getView
view.setDOMReadyCallback(onDOMReady, nil)
var url = "file:///app.html".createString
view.loadURL(url)
url.destroyString

app.run

overlay.destroyOverlay
window.destroyWindow
app.destroyApp
